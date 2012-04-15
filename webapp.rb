require 'sinatra'
require './bounty.rb'

# time to hold cached images in seconds
$cache_hold_time = 3600

get '/bounty.png' do
  if /http:\/\/(?:meta\.)?(?<domain>[\w\.]+)/ =~ request.referrer
    if not File.exists?("./cache/#{domain}.png") or
      (Time.now - File.mtime("./cache/#{domain}.png")) >= $cache_hold_time
      generate(domain)
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

