ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'rack/test'
require 'capybara'
require 'capybara/dsl'

require File.join(File.dirname(__FILE__), '..', 'phaser_store')
