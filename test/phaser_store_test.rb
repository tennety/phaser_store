require File.join(File.dirname(__FILE__), 'test_helper')

include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Phaser Store' do
  before do
    @phaser = {:phaser => { :name => 'Classic', :price => 20.00, :quantity => 100 }}
  end

  it 'has a store page' do
    get '/store'
    last_response.ok?.must_equal true
  end

  describe 'adding products' do
    it 'lets user add products' do
      get '/admin/phasers/new'
      last_response.ok?.must_equal true
    end

    it 'records user added product and redirects to the store' do
      lines = Phaser.count

      post '/phasers', @phaser
      last_response.redirect?.must_equal true

      follow_redirect!

      last_response.body.must_include "Classic"
      (Phaser.count - lines).must_equal 1
    end
  end

  describe 'checking out' do

  end
end
