require './application'

set :run, false
set :environment, ENV['RACK_ENV'] || 'production'

run MyBower

