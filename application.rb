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

require "rack/oauth2/sinatra"

set :root_path, File.dirname(__FILE__)
require File.expand_path('../config/init', __FILE__)

class MyBower < Sinatra::Base

  register Rack::OAuth2::Sinatra

  oauth.database = Mongo::Connection.new["bower_admin"]
  oauth.authenticator = lambda do |username, password|
    #user = User.find(username)
    #user if user && user.authenticated?(password)
    user = User.find_by_username(username)
    user.id if user && user.authenticated?(password)
  end

  before { @user = oauth.identity if oauth.authenticated? }

  get "/user" do
   @msg = "User: \"#{@user}\"" #"ARMtech Bower Server"
   @date = Time.now
   erb :index
  end

  oauth_required "/packages/a"
  oauth_required "/packages/d"
  #oauth_required "/packages"


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

  post '/packages/a' do
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

  delete '/packages/d' do
    begin
      package = Package[:name => params[:name]].destroy()
      201
    rescue Sequel::ValidationFailed
      400
    rescue Sequel::DatabaseError
      406
    end
  end

end
