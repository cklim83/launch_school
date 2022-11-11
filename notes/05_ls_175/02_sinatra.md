# App Development With Sinatra

## Section Links
[What is Sinatra?](#what-is-sinatra)\
[Install Dependencies](#install-dependencies)\
[Components of a Ruby Application](#components-of-a-ruby-application)
- [Routes](#routes)
- [Templates](#templates)
- [Layouts](#layouts)
- [Before Filter](#before-filter)
- [View Helpers](#view-helpers)
- [Not Found](#not-found)
- [Redirect](#redirect)
- [Headers](#headers)
- [Putting It All Together](#putting-it-all-together)

[File Types](#file-types)\
[Other Pointers](#other-pointers)


---

## What is Sinatra?
- Sinatra is a small web framework based on Ruby.

## Install Dependencies
- Create a Gemfile with the following gems
```Ruby
# Gemfile
source "https://rubygems.org"

gem "sinatra", "~>1.4.7"
gem "sinatra-contrib"
gem "erubis"

gem "webrick" # if using Ruby 3.0 or higher
```
- Run bundle install to install the gems and dependencies. 

[Back to Top](#section-links)


## Components of a Ruby Application
### Routes
- Routes are how developers map URL patterns to code. Sinatra provides a Domain Specific Language (DSL) for defining routes. 
- A route consists of a **HTTP method** paired with a **URL-matching pattern** and is associated with a block containing the code to run for the matching URL.
- To use Sinatra, we include `sinatra` and `sinatra/reloader` libraries in our ruby application. The former provide useful methods to make building a Rack compliant web application easier while the latter automatically reload application files every time we load a page. allowing code changes to be reflected without the need to restart the server.

	**Route Example**
	```ruby
	require "sinatra"
	require "sinatra/reloader"
	
	get "/" do
	  File.read "public/template.html"
	end
	```
	`get "/"` declares a route matching an URL with a path of `"/"`. When a user visits that path, the accompanying block is executed and return value is then sent to the user's browser.
- Query string in a URL e.g. `?name1=value1&name2=value2` are automatically extracted and stored as key-value pairs in a hash and assigned to variable `params`. This variable is in scope anywhere in the ruby program. We can access a parameter value using the associated key in symbol or string form: `params[:parameter_name]` or `params["parameter_name"]`.
- Sinatra also allows the use of a **symbol** to capture a parameter in an URL when defining a route. 
	```Ruby
	get "/show/:name" do
	  params[:name]
	end
	
	# URL /show/tom will map above route and params[:name] returns "tom"
	# URL /show/1 will also map above route and params[:name] returns "1"
	```
- `params` and **instance variables** defined in a route are in-scope in the template file rendered within that route.

[Back to Top](#section-links)


### Templates
- Templates (or _view templates_) are files that contain text that is converted to HTML before being sent to a user's browser in a response
- Different templating languages are available, providing different ways to generate HTML dynamically
- `ERB` is a common templating language and is the default used in Ruby on Rails. `ERB` template files have a `.erb` extension.
- By **embedding ruby code** within HTML in its template files, HTML code can be dynamically generated using Ruby constructs such as conditional and iterations. Embedded Ruby code takes 2 forms:
	- `<% ruby code %>`: Ruby code is **evaluated but value not inserted** into resultant HTML file.
	- `<%= ruby code %>`: Ruby code is **evaluated and value inserted** into resultant HTML file.
- An `erb` file rendered within a route can access `params` and all **instance variables** defined in that route. 
	```markup
	...
	
	<ul class="pure-menu-list">
	  <% @contents.each do |chapter| %>
	    <li class="pure-menu-item">
	      <a href="#" class="pure-menu-link"><%= chapter %></a>
	    </li>
	  <% end %>
	</ul>
	
	...
	```
- To use ERB within a ruby web application, we
	- create a view template in the views folder e.g. `views/home.erb`
	- add `tilt/erubis` library within the ruby application file
	- call `erb` and pass the filename in symbol form as an argument to render the template
	```ruby
	get "/" do
	  erb :home
	end
	```

[Back to Top](#section-links)


### Layouts
- Web pages of the same domain tend to share common HTML code for certain section(s) of a page e.g. common headers, navigation menu and footers.
- Instead of repeating **common HTML code** across multiple template files, common code can be placed in a **layout file** and `<%= yield %>` tag is used in sections where the code differs.
- The layout file is itself a view template, but it will insert the content of an associated view template at the location of the `<%= yield %>` tag when generating the HTML.
- When we invoke the `erb` method call, we pass in view template to be rendered, and a second option argument, the layout file used to wrap the view template.

	A page like this:
	```markup
	# views/index.erb
	<html>
	  <head>
	    <title>Is it your birthday?</title>
	  </head>
	  <body>
	    <p>Yes, it is!</p>
	  </body>
	</html>
	```

	Can be broken down into a layout:
	```markup
	# views/post.erb
	<html>
	  <head>
	    <title>Is it your birthday?</title>
	  </head>
	  <body>
	    <%= yield %>
	  </body>
	</html>
	```

	and a view template:
	```markup
	# views/index.erb
	<p>Yes, it is!</p>
	```

	In the associated route in the ruby application file.
	```ruby
	get '/' do
	  erb :index, layout: :post
	end
	```

- By default, Sinatra will look for a `layout.erb` file in the `views` directory and use it to wrap the template e.g. `index.erb` below.  If `layout.erb` doesn't exist, it will just render the template without a layout. 
  ```ruby
	get '/' do
	  erb :index # layout.erb is used by default
	end
  ```

[Back to Top](#section-links)


### Before Filter
- There are things that need to be done on every request to an application e.g. checking authentication status
- Code to perform these tasks can be placed in a `before` block as they are executed before the matching route for every request.
	```Ruby
	before do
	  ...
	end
	```
- Variables that are needed globally can also be initiated in this block as they will then be in scope for all routes (and associated templates) 

[Back to Top](#section-links)


### View Helpers
- _View helpers_ are Ruby methods that are used to minimize the amount of Ruby code included in a view template. These methods are defined within a `helpers` block in Sinatra.
- `helpers` block is best placed after the `configure` block and before the `before` block
- Methods to be used in both view templates and the application are placed here. Methods that are only used within the application should not be in the `helpers` block but should just exist as a normal method definition within the application file.

	```ruby
	helpers do
	  def slugify(text)
	    text.downcase.gsub(/\s+/, "-").gsub(/[^\w-]/, "")
	  end
	end
	```
	
	These can then be used like any other method in a template:
	```markup
	<a href="/articles/<%= slugify(@title) %>"><%= @title %></a>
	```
	
	Assuming `@title == "Today is the Day"`, the expected output will be:
	```markup
	<a href="/articles/today-is-the-day">Today is the Day</a>
	```

[Back to Top](#section-links)


### Not Found
- Sinatra also provide a special `not_found` route to catch all incoming requests that fail to match any other route.
	```Ruby
	not_found do
	  "The page was not found"
	  # redirect "/some_path"
	end
	```

[Back to Top](#section-links)


### Redirect
- It is common to redirect a user to another page after performing certain actions e.g. authentication or submission of data.
- Sinatra has a `redirect` method to redirect a user to another page.
	```ruby
	redirect "/a/good/path"
	```
- A redirect will result in a response with `30x` status code and a `Location` response header that contains the new path a browser should be redirected to. A browser will automatically issue a new request to the new path when it process the response.
- Sometime a route could end up matching an **invalid** or **out-of-range** parameter. We can add logic to redirect only if the parameter passes a validation check.

	  **Example: Out-of-range/Invalid chapter number**
	```ruby
	get "/chapters/:number" do
	  number = params[:number].to_i
	  chapter_name = @contents[number - 1]
	
	  redirect "/" unless (1..@contents.size).cover? number
	
	  @title = "Chapter #{number}: #{chapter_name}"
	  @chapter = File.read("data/chp#{number}.txt")
	
	  erb :chapter
	end
	```

[Back to Top](#section-links)


### Headers
- We can use the `headers` method to alter the value of response headers
```ruby
# changing page from html to plaintext
get "/:filename" do
  file_path = root + "/data/" + params[:filename]

  headers["Content-Type"] = "text/plain"
  File.read(file_path)
end
```

[Back to Top](#section-links)


### Putting It All Together
- A ruby web application file could have the following structure.
```ruby
# app_name.rb
require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

# set configuration
configure do
  enable :sessions
  set :session_secret, "secret"
  set :erb, :escape_html => true
end

# methods for view templates
helpers do
  ...
end

# methods for the ruby application
def method_name
  ...
end

# Execute these code before matching request to corresponding route
before do
  ...
end

# routes
get "/" do
  ...
end
```

[Sample Application](https://github.com/cklim83/launch_school/blob/main/06_rb175_networked_applications/03_project_todos/todo.rb)

**Sample Project Tree**
```plaintext
├── Gemfile
├── Gemfile.lock
├── README
├── public
│   ├── images
│   │   ├── arrow_new_list.png
│   │   ├── icon_add.png
│   │   ├── icon_check.png
│   │   ├── icon_delete.png
│   │   ├── icon_edit.png
│   │   └── icon_list.png
│   ├── javascripts
│   │   ├── application.js
│   │   ├── jquery-2.2.4.js
│   │   └── jquery-3.6.0.js
│   └── stylesheets
│       ├── application.css
│       └── whitespace-reset.css
├── todo.rb
└── views
    ├── edit_list.erb
    ├── layout.erb
    ├── list.erb
    ├── lists.erb
    └── new_list.erb
```

[Back to Top](#section-links)


## File Types
- **Gemfile** is a **server-side** file as it is used by Bundler, the Ruby dependency management system to install libraries needed to run the program.
- Ruby files are server-side files that form the core of a Sinatra application. The code within them runs on the server while handling incoming requests.
- Stylesheets `.css` are client-side files as they are interpreted by browsers to determine how to display a page.
- Javascript files `.js` are client-side files as they are evaluated by the JavaScript interpreter within a browser to add behavior to a web page.
- View templates `.erb` are server-side files. The Ruby code within these files is evaluated on the server to generate a response that will be sent to the client.

[Back to Top](#section-links)


## Other Pointers
- Data to be used in a template should be prepared in an appropriate route and made available for use in that template via an instance variable. We should refrain from using Ruby code to manipulate a variable to get it into the required form within the template. Template should just focus on rendering content.
- Use **absolute** and **NOT relative path** for **href attribute** in hyperlink objects. This is because a relative path will be **appended upon a current path**. For example, if we repeatedly click a menu link that uses a relative path, we will get a nested path that is unintended: 
	- `localhost:4567/chapter/1` upon 1st click of chapter 1 menu link
	- `localhost:4567/chapter/1/chapter/1` upon 2nd click of chapter 1 menu link
	- Using absolute link will generate `localhost:4567/chapter/1` no matter how many times we click the chapter 1 menu link.

[Back to Top](#section-links)