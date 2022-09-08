# Securing Applications

## Escaping HTML
- Developers prefer a lightweight web framework like Sinatra if they do not need the added functionalities that comes with something like Rails as there is less to learn and understand to be productive.
- A downside to using smaller and simpler tools like Sinatra is that certain tasks that are done automatically in larger frameworks have to be doned manually in Sinatra. An example is **Escaping HTML**.
- To minimize the risk of [cross-site scripting](https://github.com/cklim83/launch_school/blob/main/notes/04_ls170_171/14_security.md#cross-site-scripting-xss), a web security vulnerability involving the insertion of malicious code masquerading as normal text input through web forms that are displayed, input text have to be sanitized before they are displayed.
- To do that, we can make of the `Rack::Utils.escape_html` method in the [Rack](https://github.com/rack/rack) library that Sinatra is based on.
   ```irb
   >> require "rack"
   => true
   >> Rack::Utils.escape_html "test"
   => "test"
   >> Rack::Utils.escape_html %{<script>alert("This code was injected!"); 
   </script>Pizza}
   => "&lt;script&gt;alert(&quot;This code was 
   injected!&quot;);&lt;&#x2F;script&gt;Pizza"
   ```
- Instead of manually escaping every place where untrusted input may be rendered on a page and running the risk of missing a few places, the recommended approach is to escape all code by default, then selectively disable auto-escaping in places we are sure do not need escaping.
	```ruby
	configure do
	  set :erb, :escape_html => true
	end
	```
	To do that, we set the above configuration. Sinatra will then run through all templates and apply `Rack::Utils.escape_html` on all values within `<%= ... %>`. For tags containing values we do not want to escape e.g. hyperlinks etc, we add an extra `=` to the tag to make it `<%== ... %>` so that Sinatra knows not to escape them. 
	
	**Note:** adding an additional `=` to form `<%== yield %>` will still embed the content of the template to the layout file. The extra `=` is just to inform Sinatra not to pass the value through the `escape_html` method.

### Example On Escaping
- The display form after a value is escape may look the same as the original text but the value has actually changed.

	Original text:
	```plaintext
	`<script>alert("This code was injected!");</script>Pizza`
	```
	
	Value after **single pass** with escape_html: 
	```plaintext
	`&lt;script&gt;alert(&quot;This code was injected!&quot;);&lt;&#x2F;script&gt;Pizza`
	```
	
	Single passed value in displayed form:
	```plaintext
	`<script>alert("This code was injected!");</script>Pizza`
	```
	
	
	Value after **double pass** with escape_html: 
	```plaintext
	 `&amp;lt;script&amp;gt;alert(&amp;quot;This code was injected!&amp;quot;);&amp;lt;&amp;#x2F;script&amp;gt;Pizza`
	```
	
	Double passed value in displayed form : 
	```plaintext
	`&lt;script&gt;alert(&quot;This code was injected!&quot;);&lt;&#x2F;script&gt;Pizza`
	```

## HTTP Methods and Security
- Using `POST` rather than `GET` for a request is **not** more secure. Both request are sent as **plain text** regardless of the HTTP used and are equally valunerable to being seen while in transit on the network. The only difference is  `GET` will append the submitted parameters to the URL while `POST` will send the parameters in the request body, giving it a false sense of extra security.
- The way to prevent data sent between client and server from being viewed by other parties is to serve the application over HTTPS which ensure the data exchanged are sent in encrypted form during transit.


