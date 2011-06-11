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

end
