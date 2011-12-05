require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'json'

APP_ROOT = File.expand_path(File.dirname(__FILE__))
$:.unshift File.join(APP_ROOT, 'lib')

Dir.glob("#{APP_ROOT}/lib/*.rb").each{ |f| require f }
