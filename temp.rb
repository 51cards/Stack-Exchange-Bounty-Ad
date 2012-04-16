require './bounty.rb'
require 'sinatra'

get // do
  generate("apple.stackexchange.com")
end