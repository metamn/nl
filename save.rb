require 'rubygems'
require './db.rb'

class Save

  def self.twitter(tweets)
    tweets.each do |t|
      tweet = Raw.new(
        :source => 'twitter',
        :user => t.user.name,
        :date => t.created_at,
        :link => "http://twitter.com/#!/#{t.user.name}/status/#{t.id_str}",
        :content => t.text
      )
      t.entities.hashtags.each do |h| 
        tweet.tags.build(
          :name => h.text
        )
      end
      tweet.save!
    end
  end


  def self.channels2
    Raw.all(:limit => 10, :offset => 150).each do |r|
      puts "r: #{r.content}"
      unless r.tags.blank?
        puts "tags: #{r.tags.join(', ')}"
        r.tags.each do |t|
          puts "t: #{t.name}"
          ch = Channel.find_or_create_by_name t.name
          ch.raws << r
          ch.save!
          puts "saved. raw size: #{ch.raws.size}"
        end
      end
    end
  end
  
  
  def self.channels
    Raw.all(:limit => 10, :offset => 150).each do |raw|
      next if raw.tags.blank?
      raw.tags.each do |tag|
        ch = Channel.where :name => tag.name
        ch = Channel.new :name => tag.name if ch.blank?
        ch.raw_ids << raw.id
        ch.save!
      end
    end
  end
  
  
end
