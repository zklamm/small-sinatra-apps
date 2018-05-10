require 'sinatra'
require 'sinatra/reloader'

get '/' do
  @files = Dir.glob('*').map { |file| File.basename(file) }.sort
  
end