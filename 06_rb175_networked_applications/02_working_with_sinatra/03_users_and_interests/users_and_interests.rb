require "sinatra"
require "sinatra/reloader"
require 'yaml'

before do
  @users = Psych.load_file("users.yaml")  
end

get '/' do
  redirect '/users'
end

get '/users' do
  erb :users
end

get '/user/:name' do
  @user_name = params[:name].to_sym
  user_profile = @users[@user_name]
  @email = user_profile[:email]
  @interests = user_profile[:interests]
  @other_users = @users.keys.select { |user| user != @user_name }.sort
 
  erb :user_profile
end

helpers do
  def count_interests
    interest_count = 0
    @users.each do |user_name, user_details|
      interest_count += user_details[:interests].size
    end

    interest_count
  end
  
  def capitalize(string)
    string.capitalize
  end
end
