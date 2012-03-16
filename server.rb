require 'sinatra'
require './models'
require "sinatra/reloader" if development?

get '/ping' do
  "Pong @ #{Time.now.to_i}\n"
end

post '/write' do
  start_time = Time.now
  puts start_time.usec
  number_of_monkeys = params[:number].to_i || 1
  shakespeare_words, unworthy_words = if number_of_monkeys == 1
    Shakespeare.new.write_with_one_monkey
  else
    Shakespeare.new.write_with_monkeys(number_of_monkeys)
  end
  puts Time.now.usec
  generate_response(start_time, shakespeare_words, unworthy_words)
end

def generate_response(start_time, shakespeare_words, unworthy_words)
  result = "SHAKESPEARE WORDS:\n"
  shakespeare_words.each do |word|
    result << word << "\n"
  end
  result << "UNWORTHY WORDS CREATED: #{unworthy_words.size}\n"
  result << "In #{ (Time.now.usec - start_time.usec)} us\n"
  result
end
