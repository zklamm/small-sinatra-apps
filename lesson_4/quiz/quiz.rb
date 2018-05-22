require 'sinatra'
require 'sinatra/reloader'
require 'tilt/erubis'

get "/" do
  @words = ["blubber", "beluga", "galoshes", "mukluk", "narwhal"]
  erb :index
end