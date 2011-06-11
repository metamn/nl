require 'rubygems'
require 'twitter'
require 'tumblr'
require 'faraday'
require 'yajl'


# Importing data from Twitter, Tumblr and Delicious
#
# Twitter import is done via https://github.com/jnunemaker/twitter
# Tumblr import is done via https://github.com/matenia/tumblr
# Delicious import is done via https://github.com/technoweenie/faraday
#
# Returns JSON ready to be inserted into database
class Import
 
  # Imports user timeline from Twitter
  #
  # user - the username
  #
  # Returns a Hashie
  def self.twitter(user)
    Twitter.user_timeline("#{user}", :count => 2, :include_rts => true, :include_entities => true) 
  end

  # Making an API call using Faraday and parsing the result with Yajl
  #
  # url   - The API address
  # query - The API query
  #
  # Returns a Hash
  def self.api(url, query)
    conn = Faraday.new(:url => "#{url}") do |builder|
      builder.request  :url_encoded
      builder.request  :json
      builder.response :logger
      builder.adapter  :net_http
    end
    
    p = conn.get "#{query}.js"
    parser = Yajl::Parser.new
    j = parser.parse(p.body)
  end    
end
  
  
