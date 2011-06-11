require 'rubygems'
require './db.rb'
require './import.rb'
require './save.rb'

tweets = Import.twitter "metamn"
Save.twitter tweets

r = Raw.where :source => 'twitter'
puts r.size
r.map {|t| puts t.content}

