require 'rubygems'
require 'mongo_mapper'


MongoMapper.database = "nl-1"

# Document holding raw import data
# -
class Raw
  include MongoMapper::Document
  
  # Database Schema
  # ----  
  # twitter, tumblr, delicious, ...
  key :source, String
    
  # @metamn, #shopledge, csbartus, ...
  key :user, String
  
  # when the item was created
  key :date, Time
  
  # the url of the original item
  # - http://twitter.com/themattharris/statuses/18498353208
  key :link, String
  
  # the content, the valuable information of this item
  # - the tweet
  # - the post on Tumblr
  # - the link on Delicious
  key :content, String
  
  # tags are EmbeddedDocuments for speed
  # there will be another separated Document called Channels, built from these tags
  many :tags
  
  # to store where this information comes from
  # - @dhh, @shopify, eigenstil/tumblr etc.
  # like tags, this is EmbeddedDocument now but later separated into a standalone Sources Document
  many :sources
end


# Embedded Document for Tags
# -
class Tag
  include MongoMapper::EmbeddedDocument
  
  key :name, String
end


# Embedded Document for Sources
# -
class Source
  include MongoMapper::EmbeddedDocument
  
  key :name, String
end

