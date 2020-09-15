require 'tilt/erubis'
require 'sinatra'
require 'sinatra/reloader'

configure do
  enable :sessions
  set :session_secret, 'super secret'
  set :erb, escape_html: true
end

helpers do
  def card_format(card_number)
    "****-****-****-#{card_number[-4..-1]}"
  end
end

get '/' do
  session[:payments] = []
  erb :index
end

get '/payments' do
  erb :payments
end

get '/payments/create' do
  erb :create_payment
end

post '/payments/create' do
  info = {
    'First Name'      => params[:first_name],
    'Last Name'       => params[:last_name],
    'Card Number'     => params[:card_num],
    'Expiration Date' => params[:exp_date],
    'CCV'             => params[:ccv]
  }

  missing = info.select { |_, value| value.strip.empty? }.keys

  if missing.empty? && params[:card_num].size == 16
    info['Time'] = Time.now
    session[:payments] << info
    session[:message] = 'Thank you for your payment.'
    redirect '/payments'
  else
    if !missing.empty?
      session[:missing_fields] = "Missing fields: #{missing.join(', ')}"
    end

    if params[:card_num].size != 16
      session[:invalid_card] = 'Card Number must be 16 characters long.'
    end
    erb :create_payment
  end
end

not_found do
  redirect '/'
end
