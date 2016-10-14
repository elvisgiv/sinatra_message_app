require 'sinatra'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/message'


require_relative 'routes/messages'