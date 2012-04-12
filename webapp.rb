require 'sinatra'
require './bounty.rb'


get '/bounty.png' do
  if /http:\/\/(?:meta\.)?(?<domain>[\w\.]+)/ =~ request.referrer
    if not File.exists?("./cache/#{domain}.png")
      generate(domain)
      status 404
      "404: does not exist in cache"
    end
    send_file "./cache/#{domain}.png"
  else
    status 404
    "404: unable to parse referrer"
  end
end

get // do
  status 404
  "404: Not Found"
end

