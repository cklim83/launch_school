require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"
require "redcarpet"
require "yaml"
require "bcrypt"

configure do
  enable :sessions
  set :session_secret, "secret"
end

def data_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/data", __FILE__)
  else
    File.expand_path("../data", __FILE__)
  end
end

def credential_path
  if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yml", __FILE__)
  else
    File.expand_path("../users.yml", __FILE__)
  end
end

def render_markdown(text)
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML)
  markdown.render(text)
end

def load_file_content(path)
  content = File.read(path)
  case File.extname(path)
  when ".txt"
    headers["Content-Type"] = "text/plain"
    content
  when ".md"
    erb render_markdown(content)
  end
end

def get_files
  pattern = File.join(data_path, "*")
  files = Dir.glob(pattern).map do |path|
    File.basename(path)
  end

  files
end

def name_taken?(filename)
  get_files.include?(filename)
end

def invalid_file_extension?(filename)
  ![".txt", ".md"].include?(File.extname(filename))
end

def get_error_message(filename)
  if filename.empty?
    "A name is required."
  elsif name_taken?(filename)
    "File already exist! Choose another name."
  elsif invalid_file_extension?(filename)
    "Invalid name! Name should end with .txt or .md"
  end
end

def signed_in_user?
  session.key?(:username)
end

def require_signed_in_user
  unless signed_in_user?
    session[:message] = "You must be signed in to do that."
    redirect "/"
  end
end

def load_user_credentials
  credentials_path = if ENV["RACK_ENV"] == "test"
    File.expand_path("../test/users.yml", __FILE__)
  else
    File.expand_path("../users.yml", __FILE__)
  end

  YAML.load_file(credentials_path)
end

def valid_credentials?(username, password)
  credentials = load_user_credentials
  
  if credentials.key?(username)
    bcrypt_password = BCrypt::Password.new(credentials[username])
    bcrypt_password == password
  else
    false
  end
end

def registration_errors
  errors = []
  credentials = load_user_credentials

  username = params[:username]
  
  if credentials.key?(username)
    errors.push("#{username} is taken! Please choose another username.")
  end

  if username.match(/\W/)
    errors.push("Username should only contain alphanumeric.")
  end

  if params[:password].size < 8
    errors.push("Password is too short! It should be at least 8 characters in length.")
  end
  
  if params[:password] != params[:confirm_password]
    errors.push("Password confirmation does not match given password.")
  end

  return errors
end

def add_user(username, password)
  users = YAML.load_file(credential_path)
  password_hash = BCrypt::Password.create(password)
  users[username] = password_hash.to_s
  File.write(credential_path, YAML.dump(users))
end

get "/" do
  @files = get_files

  erb :index
end

get "/new" do
  require_signed_in_user

  erb :new
end

post "/create" do
  require_signed_in_user
    
  filename = params[:filename].strip
  error_message = get_error_message(filename)
  
  if error_message
    session[:message] = error_message
    status 422
    erb :new
  else 
    File.write(File.join(data_path, filename), "")
    session[:message] = "#{filename} was created."
    redirect "/"
  end
end

get "/:filename" do
  file_path = File.join(data_path, params[:filename])

  if File.file?(file_path)
    load_file_content(file_path)
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

get "/:filename/edit" do
  require_signed_in_user
    
  file_path = File.join(data_path, params[:filename])
  
  if File.file?(file_path)
    @filename = params[:filename]
    @content = File.read(file_path)    
    erb :edit
  else
    session[:message] = "#{params[:filename]} does not exist."
    redirect "/"
  end
end

post "/:filename" do
  require_signed_in_user

  file_path = File.join(data_path, params[:filename])
  File.write(file_path, params[:content])
  session[:message] = "#{params[:filename]} has been updated."
 
  redirect "/"
end

post "/:filename/delete" do
  require_signed_in_user

  file_path = File.join(data_path, params[:filename])
  File.delete(file_path)
  session[:message] = "#{params[:filename]} has been deleted." 

  redirect "/"
end

get "/users/signin" do
  erb :signin
end

post "/users/signin" do
  username = params[:username]

  if valid_credentials?(username, params[:password]) 
    session[:username] = username
    session[:message] = "Welcome!"
    redirect "/"
  else
    session[:message] = "Invalid Credentials"
    status 422
    erb :signin
  end
end

post "/users/signout" do
  session.delete(:username)
  session[:message] = "You have been signed out."
  redirect "/"
end

get "/users/register" do
  erb :register
end

post "/users/register" do
  errors = registration_errors

  if errors.size > 0
    @errors = errors
    status 422
    erb :register
  else
    add_user(params[:username], params[:password])
    session[:username] = params[:username]
    session[:message] = "Welcome #{params[:username]}"
    redirect "/"
  end
end
