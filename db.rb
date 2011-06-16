require 'rubygems'
require 'mongo_mapper'


MongoMapper.database = "nl-1"

# Top level Mongo document holding raw import data
#
# source - twitter, tumblr, delicious, ....
# user - @metaman, @shopledge, csbartus, ....
# date - when the item was created
# link - the url of the item
# item - the content, the valuable information of this item
# tags - tags associated of this item
# refs - references to other items 
class Raw
  include MongoMapper::Document
  
  key :source, String
  key :user, String
  key :date, Time
  key :link, String
  key :content, String
  
  many :tags
  many :refs
end


# Embedded Mongo document for Tags / Raw
class Tag
  include MongoMapper::EmbeddedDocument
  
  key :name, String
end


# Embedded Mongo document for Sources (mentions) / Raw
class Ref
  include MongoMapper::EmbeddedDocument
  
  key :name, String
end


# Top level Mongo document for storing Channels
# Used to convert Raw data into Channels 
#
# name - the channel name, the tag name
# raws - each channel has many raw items associated (many-to-many relationship with Raw)
class Channel
  include MongoMapper::Document
  
  key :name, String
  key :raw_ids, Array
  many :raws, :in => :raw_ids  
end




