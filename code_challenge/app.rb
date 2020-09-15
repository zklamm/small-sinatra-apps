require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'
require 'yaml'

before do
  @users_and_interests = YAML.load_file('users.yaml')
  @users = @users_and_interests.keys
  @num_users = @users.size
end

helpers do
  def count_interests(users_and_interests)
    num_interests = 0

    users_and_interests.each do |_, info|
      info[:interests].each do |interest|
        num_interests += 1
      end
    end

    num_interests
  end
end

get '/' do
  redirect '/users'
end

get '/users' do
  erb :users
end

get '/users/:user' do
  @user_name = params[:user].to_sym
  @email = @users_and_interests[@user_name][:email]
  @interests = @users_and_interests[@user_name][:interests]
  @users.reject! { |user| user == @user_name }

  erb :user
end
