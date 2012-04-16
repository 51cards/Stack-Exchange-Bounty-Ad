require 'serel'
require './bounty.rb'


class SiteDoesNotExistError < StandardError
end

class Site
  def initialize(domain, se)
    @domain = domain
    @se = se
  end
  
  def bounties()
    Serel::Base.config(@domain, @se.apikey)
    bounties = Serel::Question.featured.request
        
    number = bounties.length
    rep    = bounties.
      map { |bounty, total| bounty.bounty_amount }.reduce(:+)
      
    rep = 0 if number == 0
      
    [@domain, number, rep]
  end
end


class SE  
  attr_accessor :apikey
  
  def initialize(apikey)
    @apikey = apikey
    @se_sites = []
    update_sites()
  end
  
  def site(url)
    Site.new(validate(url), self)
  end
  
  def validate(url)
    domain = extract_domain(url)
    if @se_sites.include?(domain)
      domain
    elsif @se_sites.include?(domain[5..-1])
      domain[5..-1]
    else
      raise SiteDoesNotExistError
    end
  end
  
  def extract_domain(url)
    m = /^http:\/\/([\w\.]*)/.match(url)
    raise SiteDoesNotExistError if not m
    m[1]
  end
  
  def update_sites()
    Serel::Base.config('', @apikey)
    @se_sites = Serel::Site.all.
      select { |site| site.site_type == 'main_site' }.
      map    { |site| site.site_url }.
      map    { |url|  extract_domain(url) }
  end
end