#require "rack/oauth2/sinatra"
#require 'rack/oauth2'

require './application'


set :run, false
set :environment, ENV['RACK_ENV'] || 'production'


run Sinatra::Application


