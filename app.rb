require 'rubygems'
require 'sinatra'
require 'slim'

require './db.rb'

 
get '/raw' do
  @tweets = Raw.all
  slim :raw
end

get '/channels' do
  @channels = Channel.all
  slim :channels
end


