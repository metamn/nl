require 'rubygems'
require './db.rb'
require './import.rb'
require './save.rb'

#
#tweets = Import.twitter "metamn"
#Save.twitter tweets

#r = Raw.where :source => 'twitter'
#puts r.size
#r.map {|t| puts t.content}


tumblr = Import.tumblr 'metaman', 'text'
tumblr.each do |t|
  puts t['id']
end

