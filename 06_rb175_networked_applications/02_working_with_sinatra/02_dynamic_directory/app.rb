require "sinatra"
require "sinatra/reloader"
require "tilt/erubis"

get "/" do
  files_and_folders = Dir["public/*"]  # return all content in ./public folder as array of strings
  files = files_and_folders.select { |item| File.file?(item) }  # retain only files
  @filenames = files.map { |file| File.basename(file) }.sort  # strip the file prefixes
  
  @filenames.reverse! if params["sort"] == 'desc'
  
  erb :list
end
