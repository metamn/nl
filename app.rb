require 'rubygems'
require 'sinatra'
require 'haml'

require './db.rb'
  
get '/' do
  @tweet = Raw.first
  haml :index
end


