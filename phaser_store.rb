require 'sinatra'
require 'sinatra/activerecord'
require 'haml'
require 'json'

APP_ROOT = File.expand_path(File.dirname(__FILE__))
$:.unshift File.join(APP_ROOT, 'lib')
$:.unshift File.join(APP_ROOT, 'models')

Dir.glob("#{APP_ROOT}/lib/*.rb").each{ |f| require f }
Dir.glob("#{APP_ROOT}/models/*.rb").each{ |f| require f }
