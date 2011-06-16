require 'rubygems'
require 'mongoid'


Mongoid.configure do |config|
  config.master = Mongo::Connection.new.db("nl-2")
end


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
  include Mongoid::Document
  
  field :source, type: String
  field :user, type: String
  field :date, type: Date
  field :link, type: String
  field :content, type: String
  
  embeds_many :tags
  embeds_many :refs
  has_and_belongs_to_many :channels
end


# Embedded Mongo document for Tags / Raw
class Tag
  include Mongoid::Document
  
  field :name, type: String
  embedded_in :raw
end


# Embedded Mongo document for Sources (mentions) / Raw
class Ref
  include Mongoid::Document
  
  field :name, type: String
  embedded_in :raw
end


# Top level Mongo document for storing Channels
# Used to convert Raw data into Channels 
#
# name - the channel name, the tag name
# raws - each channel has many raw items associated (many-to-many relationship with Raw)
class Channel
  include Mongoid::Document
  
  field :name, type: String
  has_and_belongs_to_many :raws
end




