require 'rubygems'
require 'twitter'
require 'tumblr-api'
require 'faraday'
require 'yajl'


# Importing data from Twitter, Tumblr and Delicious
#
# Twitter import is done via https://github.com/jnunemaker/twitter
# Tumblr import is done via https://github.com/matenia/tumblr  #### NOT WORKING 
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
    Twitter.user_timeline("#{user}", :count => 200, :include_rts => true, :include_entities => true) 
  end

  def self.tumblr(user, type)
    Tumblr.blog = "#{user}"
    Tumblr::Post.all(:query => {:type => "#{type}"})
  end    
end
  
  
