#!/usr/bin/env ruby

# Parse Tumblr JSON.

require 'rubygems'
require 'json'
require 'net/http'

class String

  def strip_html
    attribute_key = /[\w:_-]+/
    attribute_value = /(?:[A-Za-z0-9]+|(?:'[^']*?'|"[^"]*?"))/
    attribute = /(?:#{attribute_key}(?:\s*=\s*#{attribute_value})?)/
    attributes = /(?:#{attribute}(?:\s+#{attribute})*)/
    tag_key = attribute_key
    tag = %r{<[!/?\[]?(?:#{tag_key}|--)(?:\s+#{attributes})?\s*(?:[!/?\]]+|--)?>}
    self.gsub(tag, '').gsub(/\s+/, ' ').strip
  end
end

stream = Net::HTTP.get 'metaman.tumblr.com', '/api/read/json'
stream.gsub!("var tumblr_api_read = ", "")
stream = stream[0..stream.size-3] # strip ';\n'

js = JSON.parse stream
js.each do |item|
  puts "======================"
  puts item.class
  puts item.first
  if item.first == "posts"
    posts = item.last
    posts.each do |post|
      puts "----------------------"
      if post["type"] == "photo"
        puts "Photo - " + post["photo-caption"].strip_html[0..31] + "..."
      elsif post["type"] == "link"
        puts post["link-text"]
      elsif post["type"] == "regular"
        puts post["regular-title"]
        #puts post.inspect
      end
      puts post["url"]
      puts post["date-gmt"]
    end
  end
end

