require 'sinatra'

get '/ping' do
  "Pong @ #{Time.now.to_i}\n"
end
