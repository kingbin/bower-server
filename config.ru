#require "rack/oauth2/sinatra"
#require 'rack/oauth2'

require './application'


set :run, false
set :environment, ENV['RACK_ENV'] || 'production'

<<<<<<< HEAD

=======
>>>>>>> cd9f52d3af2d0164fb707f6ec038a766aeb15c34
run Sinatra::Application


