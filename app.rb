require 'rubygems'
require 'sinatra'
require 'slim'

require './db.rb'

 
get '/raw' do
  @tweets = Raw.sort(:date.desc)
  slim :raw
end

get '/channels' do
  @channels = Channel.all
  slim :channels
end


