require 'rubygems'
require 'mongo_mapper'

class User
  include MongoMapper::Document

  key :name, String
  key :age,  Integer

  many :hobbies
end


class Hobby
  include MongoMapper::EmbeddedDocument

  key :name,    String
  key :started, Time
end

