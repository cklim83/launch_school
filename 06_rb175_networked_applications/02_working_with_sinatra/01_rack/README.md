# Develop WebFramework with Rack
This is a code along to understand
- Rack and its interface agreements
- Evolution of simple app
- Use of Ruby library ERM to create html templates with Ruby coded embedded
- Creation of a barebone webframe with the reusable parts such as generating response and the html file using ERB

## Running the application:
1. Pre-requisites: Ruby 2.7 and above, bundler installed
2. Download this folder
3. Install Webrick (if using Ruby 3.0 onwards) and rack gems
  ```terminal
  $ bundle install # install ruby gems and dependencies
  ```
4. Run the web server
  ```terminal
  $ bundle exec rackup config.ru -p 9595
  ```
See **Growing Your Own Web Framework with Rack Part 1** in [References](#references) if you need more details.


## References
[Growing Your Own Web Framework with Rack Part 1](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-1-8c4c630c5faf)\
[Growing Your Own Web Framework with Rack Part 2](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-2-25393c5d48bc)\
[Growing Your Own Web Framework with Rack Part 3](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-3-54ab86c569bc)\
[Growing Your Own Web Framework with Rack Part 4](https://launchschool.medium.com/growing-your-own-web-framework-with-rack-part-4-a4a4da2967a2) 
