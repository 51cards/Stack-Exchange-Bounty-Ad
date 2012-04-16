require 'sinatra'
require './se.rb'
require './bounty.rb'
require './cache.rb'

se = SE.new('y6kJ2wLn7yuN7ilUOvBRPw((')

bounty_image_cache = Cache.new(86400) do |domain, bounties, reputation|
  path = "./cache/#{domain}.png"
  bounty_image(path, bounties, reputation)
  path
end

bounty_info_cache = Cache.new(3600) do |referrer|
  bounty_image_cache[se.site(referrer).bounties]
end



get '/bounty.png' do
  begin
    expires 0
    send_file bounty_info_cache[request.referrer]
  rescue SiteDoesNotExistError
    status 404
    send_file "./resources/invalid-referrer.png"
  end
end




get // do
  status 404
  "404: Not Found"
end

