require 'rubygems'
require 'sinatra'
require 'slim'

require './db.rb'

 
get '/raw' do
  @tweets = Raw.order_by([:date, :desc])
  slim :raw
end

get '/channels' do
  @channels = Channel.order_by([:count, :desc])
  slim :channels
end

get '/groups' do
  @groups = Group.all
  slim :groups
end


