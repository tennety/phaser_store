require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

include Capybara::DSL
include Rack::Test::Methods

def app
  Sinatra::Application
end

describe 'Phaser Store' do
  before do
    Capybara.app = Sinatra::Application.new
    @phaser = {:phaser => { :name => 'Classic', :price => 20.00, :quantity => 100 }}
    @receipt = {:receipt => { :name => 'Classic', :price => 20.00, :quantity => 10, :status => 'created' }}
    Phaser.all.map(&:destroy)
    Receipt.all.map(&:destroy)
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

      post '/phaser', @phaser
      last_response.redirect?.must_equal true

      follow_redirect!

      last_response.body.must_include "Classic"
      (Phaser.count - lines).must_equal 1
    end
  end

  describe 'checking out' do
    it 'has no Checkout button for an empty store' do
      visit '/store'
      within_table('catalog') do
        page.has_button?('Checkout with 2CO').must_equal false
      end
    end

    it 'has a Checkout button for each line' do
      post '/phaser', @phaser

      visit '/store'
      within_table('catalog') do
        page.has_button?('Checkout with 2CO').must_equal true
      end
    end

    describe '/receipt' do
      before do
        post '/phaser', @phaser
        @receipt[:receipt].merge!(:phaser_id => Phaser.first.id)
      end

      it 'creates an order for the specified line' do
        receipts = Receipt.count

        post '/receipt', @receipt
        last_response.redirect?.must_equal true

        (Receipt.count - receipts).must_equal 1
      end

      it 'decrements the stock for the line by the order quantity' do
        Phaser.first.quantity.must_equal @phaser[:phaser][:quantity]

        post '/receipt', @receipt
        Phaser.first.quantity.must_equal (@phaser[:phaser][:quantity] - @receipt[:receipt][:quantity])
      end

      it 'redirects to 2Checkout with the order parameters' do
        post '/receipt', @receipt
        target = URI.parse last_response.location
        target.host.must_equal 'www.2checkout.com'
        target.path.must_match /purchase/
      end
    end
  end
end
