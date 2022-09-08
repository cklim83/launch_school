# Deploying Sinatra Application

## Section Links
[Prerequisites](#prerequisites)\
[Configuring Application for Deployment](#configuring-application-for-deployment)\
[Create a Heroku Application](#create-a-heroku-application)

---

## Prerequisites
1. Install the [Heroku Command Line Interface (CLI)](https://devcenter.heroku.com/articles/heroku-cli). Login using `heroku login`. AWS Cloud 9 users may experience permission issues i.e. script requiring superuser access and/or complaints about `/usr/local/bin`. If so, try the following commands instead:
	```shell
	sudo su -
	export PATH="/usr/local/bin:$PATH"
	curl https://cli-assets.heroku.com/install.sh | sh
	exit
	```

2. Heroku requires a project to be stored in a Git repository. Create a Git repository and commit all the project's files in it.

[Back to Top](#section-links)


## Configuring Application for Deployment
1. **Prevent application from reloading in production** by adding `if development?` to the line that requires `sinatra/reloader`.
	```ruby
	# app_name.rb
	require "sinatra/reloader" if development?
	```
	Sinatra provides `development?` and `production?` methods that returns a boolean based on the value of the `RACK_ENV` environment variable. This variable is set to `"production"` by Heroku on deployment, which cause `development?` to return `false`, thus omitting the reloader library in production.

2. **Specify the Ruby version in `Gemfile`** so the same version is used in both development and production. 
	```ruby
	ruby "2.4.1"
	```
	Be sure to run bundle install after changing the `Gemfile`.

	If you don't set the version, you will see an error similar to the one below when you push to Heroku.
	```terminal
	remote: ###### WARNING:
	remote:        You have not declared a Ruby version in your Gemfile.
	remote:        To set your Ruby version add this line to your Gemfile:
	remote:        ruby '2.0.0'
	remote:        # See https://devcenter.heroku.com/articles/ruby-versions for more information.
	```
	
3. **Switch from WEBrick**, Ruby's default web server, **to a production capable web server.** While WEBrick is suitable for local development, it was not designed to handle a high concurrent workload that a Ruby app could face in production. See here for [details](https://devcenter.heroku.com/articles/ruby-default-web-server). We could use **Puma**, a multi-threaded web server that can handle more than one request concurrently, by adding the following to a gem file, then run `bundle install` to install any new dependencies. 
	```ruby
	group :production do
	  gem "puma"
	end
	```
4. **Create a `config.ru` file** in root of the project. This file will tell the web server how to start the application.
	```ruby
	require "./book_viewer"
	run Sinatra::Application
	```

5. **Create a `Procfile`** in the root of project. Heroku uses the `Profile` to determine
	- which processes to run when a user uses the application
	- the web server on which the application runs
	- the port number that the web server will use for the application.  
	
	See [Heroku Documentation](https://devcenter.heroku.com/articles/procfile) for details.

	For simple application, we can provide the configuration inline in the `Procfile` as shown below.
	```none
	web: bundle exec puma -t 5:5 -p ${PORT:-3000} -e ${RACK_ENV:-development}
	```
	
	For larger applications, it is recommended to use a separate config file for Puma instead of providing its configuration inline. See this [article](https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server) for details.

	If procfile is omitted, we will encounter an error similar to the one below when pushing to Heroku.
	```terminal
	remote: ###### WARNING:
	remote:        No Procfile detected, using the default web server (webrick)
	remote:        https://devcenter.heroku.com/articles/ruby-default-web-server
	```

6. **Test Procfile locally**. Run the `heroku local` command to boot the project locally to test out its behavior before pushing to Heroku. This provides an opportunity to troubleshoot problems in your local development environment.

	You should see an output like this:
	```terminal
	$ heroku local
	forego | starting web.1 on port 5000
	web.1  | Puma starting in single mode...
	web.1  | * Listening on tcp://0.0.0.0:5000
	web.1  | Use Ctrl-C to stop
	```

	If you get an error message that says something like `Address already in use - bind(2) for "0.0.0.0" port 5000`, you may have a process on your system that is already using port 5000. The easiest way to work around this problem is to use a different port for your code. For instance:
	```terminal
	$ heroku local -p 5555
	```

	You should be able to visit the application at [localhost:5000](http://localhost:5000) and test it out. If everything appears to be working, you can proceed with the next step: deploying to Heroku. If you used the `-p` option when launching `heroku local`, replace `5000` with the appropriate port number when entering the URL in the browser.

**Sample Project Tree**
```plaintext
├── Gemfile
├── Gemfile.lock
├── Procfile
├── README
├── config.ru
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


## Create a Heroku Application
1. Set a place on Heroku for our application using `heroku apps:create $NAME`, where `$NAME` is the application name to be used. If this value is not provided, Heroku generate a random application name. 

	```shell
	$ heroku apps:create ls-rb170-book-viewer
	Creating ls-rb170-book-viewer... done, stack is cedar-14
	https://ls-rb170-book-viewer.herokuapp.com/ | https://git.heroku.com/ls-rb170-book-viewer.git
	Git remote heroku added
	```

	**Note**: 
	- You may have seen the command `heroku create $NAME` in some Heroku articles. `heroku create` is an alias for the command `heroku apps:create` we use above.
	- Create will automatically set the remote repository to the one created on heroku. If local project repository is not created before this step, we will have to either manually set the remote repository later or run create again with a different app name.

2. Push the project to new Heroku application using `git push heroku main`.

	```shell
	$ git push heroku main
	Counting objects: 152, done.
	Delta compression using up to 12 threads.
	Compressing objects: 100% (148/148), done.
	Writing objects: 100% (152/152), 93.86 KiB | 0 bytes/s, done.
	Total 152 (delta 80), reused 0 (delta 0)
	remote: Compressing source files... done.
	remote: Building source:
	remote:
	remote: -----> Ruby app detected
	remote: -----> Compiling Ruby/Rack
	remote: -----> Using Ruby version: ruby-2.2.3
	remote: -----> Installing dependencies using bundler 1.9.7
	remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
	remote:        Fetching gem metadata from https://rubygems.org/..........
	remote:        Fetching version metadata from https://rubygems.org/..
	remote:        Installing multi_json 1.11.2
	remote:        Installing erubis 2.7.0
	remote:        Installing backports 3.6.6
	remote:        Installing tilt 2.0.1
	remote:        Using bundler 1.9.7
	remote:        Installing rack 1.6.4
	remote:        Installing rack-test 0.6.3
	remote:        Installing rack-protection 1.5.3
	remote:        Installing puma 2.15.3
	remote:        Installing sinatra 1.4.6
	remote:        Installing sinatra-contrib 1.4.6
	remote:        Bundle complete! 4 Gemfile dependencies, 11 gems now installed.
	remote:        Gems in the groups development and test were not installed.
	remote:        Bundled gems are installed into ./vendor/bundle.
	remote:        Bundle completed (3.95s)
	remote:        Cleaning up the bundler cache.
	remote:
	remote: -----> Discovering process types
	remote:        Procfile declares types     -> web
	remote:        Default types for buildpack -> console, rake
	remote:
	remote: -----> Compressing... done, 17.5MB
	remote: -----> Launching... done, v4
	remote:        https://ls-rb170-book-viewer.herokuapp.com/ deployed to Heroku
	remote:
	remote: Verifying deploy... done.
	To https://git.heroku.com/ls-rb170-book-viewer.git
	 * [new branch]      main -> main
	```

	Note: Heroku only looks at the `main` branch of a repository when processing a `git push`. This means that you must push the code you want to be run on Heroku to the remote `main` branch, regardless of what branch it is in locally.
	
	If you have been working in a branch, you can push that branch to Heroku by specifying its name when pushing:

	```shell
	git push heroku local-branch-name:main
	```

	Otherwise, you can merge your changes into your local main branch and push using `git push heroku main`.

3. Visit application and verify everything is working using `heroku open`.
4. Recall we expect Heroku to set `RACK_ENV` environment variable to `"production"`. To see this, you run `heroku config` in the project directory after deploying to Heroku.

	```bash
	$ heroku config
	=== ls-rb170-book-viewer Config Vars
	LANG:     en_US.UTF-8
	RACK_ENV: production
	```
	Adding a default value for `RACK_ENV` is a special feature of Heroku. 
	Environment variables are often used to provide API keys and other secret values to applications so that these sensitive information can be omitted from the source code committed in repositories.
	
5. To update the application after making changes, use `git push heroku main` to push the updated code onto heroku.

[Back to Top](#section-links)