require 'sinatra/sequel'
require 'sqlite3'
require 'logger'


#############
# Database Connections
configure :production do

  #p "configure prod"

  apps=File.expand_path("#{settings.root_path}/db/bower.db.sqlite",__FILE__)
  #p "db: #{apps}"  #db: /var/websites/bower-server/config/init.rb/db/bower.db.sqlite
  set :database, "sqlite://#{apps}"
  #database.logger = Logger.new(File.expand_path("#{settings.root_path}/log/db.log",__FILE__))

  #p "the packages table doesn't exist" if !database.table_exists?('packages')
end

configure :development do

  #p "configure dev"

  apps=File.expand_path("#{settings.root_path}/db/bower.db.sqlite",__FILE__)
  #p "db: #{apps}"  #db: /var/websites/bower-server/config/init.rb/db/bower.db.sqlite
  set :database, "sqlite://#{apps}"
  #database.logger = Logger.new(File.expand_path("#{settings.root_path}/log/db.log",__FILE__))

  #p "the packages table doesn't exist" if !database.table_exists?('packages')
end

configure :test do
  p "configure test"
  set :database, 'sqlite:/'
end






#############
# DB Migrations & Models

require File.expand_path('../migrations', __FILE__)

Sequel::Model.strict_param_setting = false

#p "#{settings.root_path}/models/"
Dir.glob("#{settings.root_path}/models/*.rb") do |model|
  require model
end


#helpers do
#  include Rack::Utils
#  alias_method :h, :escape_html

#  # partial helper taken from Sam Elliot (aka lenary) at http://gist.github.com/119874
#  # which itself was based on Chris Schneider's implementation:
#  # http://github.com/cschneid/irclogger/blob/master/lib/partials.rb
#  def partial(template, *args)
#    template_array = template.to_s.split('/')
#    template = template_array[0..-2].join('/') + "/_#{template_array[-1]}"
#    options = args.last.is_a?(Hash) ? args.pop : {}
#    options.merge!(:layout => false)
#    if collection = options.delete(:collection) then
#      collection.inject([]) do |buffer, member|
#        buffer << erb(:"#{template}", options.merge(:layout =>
#        false, :locals => {template_array[-1].to_sym => member}))
#      end.join("\n")
#    else
#      erb(:"#{template}", options)
#    end
#  end
#end



