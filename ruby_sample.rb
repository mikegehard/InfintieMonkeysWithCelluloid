require 'sinatra'
require "sinatra/reloader" if development?

get '/ping' do
  "Pong @ #{Time.now.to_i}\n"
end

post '/write' do
  start_time = Time.now
  number_of_monkeys = params[:number] || 1
  "Start time: #{start_time.to_i}\nNumber of monkeys #{number_of_monkeys}\n"
end
