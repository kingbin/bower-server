# ==========================================
# BOWER: Server
# ==========================================
# Copyright 2012 Twitter, Inc
# Licensed under The MIT License
# http://opensource.org/licenses/MIT
# ==========================================

require 'rubygems'
require 'sinatra'
require 'json'
require 'sequel'
require 'sinatra/sequel'

#require 'padrino-helpers'
#require 'logger'

#require "rack/oauth2/sinatra"

#  register Rack::OAuth2::Sinatra
#
#  oauth.database = Mongo::Connection.new["bower_admin"]
#  oauth.authenticator = lambda do |username, password|
#    #user = User.find(username)
#    #user if user && user.authenticated?(password)
#    user = User.find_by_username(username)
#    user.id if user && user.authenticated?(password)
#  end
#
#
#  get "/oauth/authorize" do
#    if current_user
#      render "oauth/authorize"
#    else
#      redirect "/oauth/login?authorization=#{oauth.authorization}"
#    end
#  end
#
#  post "/oauth/grant" do
#    oauth.grant! "Superman"
#  end
#
#  post "/oauth/deny" do
#    oauth.deny!
#  end
#
#  before do
#    @current_user = User.find(oauth.identity) if oauth.authenticated?
#  end
#
#  oauth_required "/packages/d"

set :root_path, File.dirname(__FILE__)

require File.expand_path('../config/init', __FILE__)

get '/' do
 @msg = "ARMtech Bower Server"
 @date = Time.now
 erb :index
end

get '/' do
 @msg = "ARMtech Bower Server"
 @date = Time.now
 erb :index
end

get '/packages' do
  Package.order(:name).all.to_json
end

get '/packages/:name' do
  package  = Package[:name => params[:name]]

  return 404 unless package

  package.hit!
  package.to_json
end

get '/packages/search/:name' do
  packages = Package.filter(:name.ilike("%#{params[:name]}%")).order(:hits.desc)
  packages.all.to_json
end

post '/packages' do
  begin
    Package.create(
      :name => params[:name],
      :url  => params[:url]
    )
    201
  rescue Sequel::ValidationFailed
    400
  rescue Sequel::DatabaseError
    406
  end
end

delete '/packages' do
  begin
    package = Package[:name => params[:name]].destroy()
    201
  rescue Sequel::ValidationFailed
    400
  rescue Sequel::DatabaseError
    406
  end
end
