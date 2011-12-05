ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'

require File.join(File.dirname(__FILE__), '..', 'phaser_store')
