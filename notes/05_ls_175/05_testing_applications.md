# Testing Sinatra Applications

## Using Rack::Test and Sinatra
```ruby
# app.rb
require "sinatra"

get "/" do
  "Hello, world!"
end
```

```ruby
# test/app_test.rb
ENV["RACK_ENV"] = "test"

require "minitest/autorun"
require "rack/test"

require_relative "../app"

class AppTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def test_index
    get "/"
    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_equal "Hello, world!", last_response.body
  end
end
```
- We set the `RACK_ENV` environment variable to "test". This value is used by various parts of Sinatra and Rack to know if code is being tested. For Sinatra, it use this to determine to start a web server (we do not want it to if we are running tests)
- Requiring `minitest/autorun` loads Minitest and configure it to run any test defined.
- Requiring `rack/test` gives us access to Rack::Test helper methods. As `rack/test` does not comes with Sinatra, we need to add the `rack-test` gem in our Gemfile
- The we require our application using `require_relative "../app"`
- Similar to running Minitest test for user defined classes, we create an `AppTest` class that subclass  `Minitest::Test`. Then, we create test cases using instance methods that starts with `test_`.
- We mix in `Rack::Test::Methods` into the AppTest class to gain access to some useful testing helper methods. These methods require an `app` method to return an instance of a Rack application when called.
	```ruby
	include Rack::Test::Methods
	
	def app 
	  Sinatra::Application
	end
	```
- Now we can write a test. The following test makes a GET request to our application using the path `/` and verifies the status code, content type header and body of the response.
	```ruby
	def test_index
	  get "/"
	  assert_equal 200, last_response.status
	  assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
	  assert_equal "Hello, world!", last_response.body
	end
	```

- We run the test by providing the path to the `ruby` command
	```terminal
	$ bundle exec ruby test/app_test.rb
	Run options: --seed 58361
	
	
	# Running:
	
	AppTest .
	
	Finished in 0.017774s, 56.2624 runs/s, 168.7873 assertions/s.
	
	1 runs, 3 assertions, 0 failures, 0 errors, 0 skips
	```

## General Approach to Testing Sinatra Applications
1. Makr a request to the application using `get`, `post` or other HTTP-method named method
2. Access the response using the `last_response` method which returns an instance of `Rack::MockResponse`. Instances of this class provides `status`, `body` and `[]` methods to access their status code, body and headers respectively.
3. Make assertions against values using standard assertions supplied by `Minitest`.
4. Test cases should cover the requirements of the application.


## Isolating Test Execution
- When the application is using a common set of data for both development and testing, there is a chance modifying the application data during development could break/fail some of tests that were previously working and vice versa.
- To avoid this, we want to use a different set of data for each environment: development and test.
- If we are using a database, we could use different databases. For filesystems, we could use different directories to store those data files. 
- We want to separate data used in testing from the data native to application during usage. Else changes in application data due to usage can cause otherwise valid test to fail.

- To access message in last request during testing, we need a redirect '302'. If there is no redirect, the generation of the response body using the template will delete the session message we will not be able to access it during test. 

	```ruby
	
	def test_signin_with_bad_credentials
		post "/users/signin", username: "test", password: "test"
	    assert_equal 422, last_response.status
	    assert_nil session[:username]
	    assert_equal "Invalid Credentials", session[:message] # this test will fail as session[:message] was deleted in generating the response.
	    assert_includes last_response.body, "Invalid credentials" # Use this test instead to check the message since there is no redirect
	end
	```

	``` terminal
	 1) Failure:
	CMSTest#test_signin_with_bad_credentials [test/cms_test.rb:168]:
	Expected: "Invalid Credentials"
	Actual: nil
	```

```cms.rb
post "/users/signin" do
  if params[:username] == "admin" && params[:password] == "secret"
    session[:username] = params[:username]
    session[:message] = "Welcome!"
    redirect "/"
  else
    session[:message] = "Invalid Credentials"
    status 422
    erb :signin
  end
end
```

```views/layout.erb
<!DOCTYPE html>
<html lang="en">
...
  <body>

    <% if session[:message] %>
      <p class="message"><%= session.delete(:message) %></p>
    <% end %>

    <%= yield %>

  </body>
</html>
```

Without redirect, we have to access the message from the `last_response.body` rather than `session[:message]` since the view template would have cleared the message when generating the response.

With redirect, the message can be accessed from session

```ruby
ENV["RACK_ENV"] = "test"

require "fileutils"

require "minitest/autorun"
require "rack/test"

require_relative "../cms"

class CMSTest < Minitest::Test
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  def setup
    FileUtils.mkdir_p(data_path)
  end

  def teardown
    FileUtils.rm_rf(data_path)
  end

  def create_document(name, content = "")
    File.open(File.join(data_path, name), "w") do |file|
      file.write(content)
    end
  end

  def session
    last_request.env["rack.session"]
  end

  def test_index
    create_document "about.md"
    create_document "changes.txt"

    get "/"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "about.md"
    assert_includes last_response.body, "changes.txt"
  end

  def test_viewing_text_document
    create_document "history.txt", "Ruby 0.95 released"

    get "/history.txt"

    assert_equal 200, last_response.status
    assert_equal "text/plain", last_response["Content-Type"]
    assert_includes last_response.body, "Ruby 0.95 released"
  end

  def test_viewing_markdown_document
    create_document "about.md", "# Ruby is..."

    get "/about.md"

    assert_equal 200, last_response.status
    assert_equal "text/html;charset=utf-8", last_response["Content-Type"]
    assert_includes last_response.body, "<h1>Ruby is...</h1>"
  end

  def test_document_not_found
    get "/notafile.ext"

    assert_equal 302, last_response.status
    assert_equal "notafile.ext does not exist.", session[:message]
  end

  def test_editing_document
    create_document "changes.txt"

    get "/changes.txt/edit"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<textarea"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_updating_document
    post "/changes.txt", content: "new content"

    assert_equal 302, last_response.status
    assert_equal "changes.txt has been updated.", session[:message]

    get "/changes.txt"
    assert_equal 200, last_response.status
    assert_includes last_response.body, "new content"
  end

  def test_view_new_document_form
    get "/new"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_create_new_document
    post "/create", filename: "test.txt"
    assert_equal 302, last_response.status
    assert_equal "test.txt has been created.", session[:message]

    get "/"
    assert_includes last_response.body, "test.txt"
  end

  def test_create_new_document_without_filename
    post "/create", filename: ""
    assert_equal 422, last_response.status
    assert_includes last_response.body, "A name is required"
  end

  def test_deleting_document
    create_document("test.txt")

    post "/test.txt/delete"
    assert_equal 302, last_response.status
    assert_equal "test.txt has been deleted.", session[:message]

    get "/"
    refute_includes last_response.body, %q(href="/test.txt")
  end

  def test_signin_form
    get "/users/signin"

    assert_equal 200, last_response.status
    assert_includes last_response.body, "<input"
    assert_includes last_response.body, %q(<button type="submit")
  end

  def test_signin
    post "/users/signin", username: "admin", password: "secret"
    assert_equal 302, last_response.status
    assert_equal "Welcome!", session[:message]
    assert_equal "admin", session[:username]

    get last_response["Location"]
    assert_includes last_response.body, "Signed in as admin"
  end

  def test_signin_with_bad_credentials
    post "/users/signin", username: "guest", password: "shhhh"
    assert_equal 422, last_response.status
    assert_nil session[:username]
    assert_includes last_response.body, "Invalid credentials"
  end

  def test_signout
    get "/", {}, {"rack.session" => { username: "admin" } }
    assert_includes last_response.body, "Signed in as admin"

    post "/users/signout"
    assert_equal "You have been signed out", session[:message]

    get last_response["Location"]
    assert_nil session[:username]
    assert_includes last_response.body, "Sign In"
  end
end
```