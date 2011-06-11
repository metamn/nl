require 'rubygems'
require './db.rb'

class Save

  def self.twitter(tweets)
    tweets.each do |t|
      tweet = Raw.new(
        :source => 'twitter',
        :user => t.name,
        :date => t.created_at,
        :link => '',
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

end
