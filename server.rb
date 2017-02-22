require 'rack'
require 'thin'
require_relative 'app'


#Rack::Handler::WEBrick.run App
Rack::Handler::Thin.run App
