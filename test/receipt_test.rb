require File.join(File.expand_path(File.dirname(__FILE__)), 'test_helper')

describe Receipt do
	describe '#checkout_url' do
		before do
			@receipt = Receipt.create(name:'Classic', price:20.00, quantity:10, status:'created')
			@url = URI.parse(@receipt.checkout_url)
		end

		it 'contains the multi-page 2CO base url' do
			@url.scheme.must_equal 'https'
			@url.host.must_equal 'www.2checkout.com'
			@url.path.must_equal '/checkout/purchase/'
		end

		it 'builds the query string from the receipt checkout attributes' do
			@url.query.must_match /demo=Y&fixed=Y&li_1_name=Classic&li_1_price=20.0&li_1_quantity=10&li_1_tangible=Y&li_1_type=product&mode=2CO&sid=\d{7}/
		end
	end
end
