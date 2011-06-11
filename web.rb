require 'rubygems'
require 'sinatra'
require './db.rb'
require 'haml'
require 'mustache'
  
get '/' do
  'Hello world!'
  @tweet = Raw.first
  mustache :index, :name => 'MUstAcHEsss'
end

def mustache(template, args)
  Mustache.render File.new("#{:views}/#{template}.mustache", "r").read, args
end

