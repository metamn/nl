require 'rubygems'
require './db.rb'

class Save

  def self.twitter(tweets)
    tweets.each do |tweet|
      raw = Raw.new(
        :source => 'twitter',
        :user => tweet.user.name,
        :date => tweet.created_at,
        :link => "http://twitter.com/#!/#{tweet.user.name}/status/#{tweet.id_str}",
        :content => tweet.text
      )
      tweet.entities.hashtags.each do |hashtag| 
        tag = Tag.new :name => hashtag.text
        raw.tags << tag
      end
      raw.save!
    end
  end


  def self.channels
    Raw.all.each do |raw|
      next if raw.tags.blank?
      raw.tags.each do |tag|
        channel = Channel.find_or_create_by :name => tag.name
        channel.raws << raw
        channel.save!
      end
    end
  end
  
  
end
