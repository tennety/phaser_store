class Receipt < ActiveRecord::Base
	SID = '1642674'
	LINE_ITEM_KEYS = {
		"product_type" => "li_1_type",
		"name"         => "li_1_name",
		"price"        => "li_1_price",
		"quantity"     => "li_1_quantity",
		"tangible"     => "li_1_tangible"
	}

	after_create :build_x_receipt_link_url

  def checkout_url
		url = URI.parse('https://www.2checkout.com/checkout/purchase/')
		url.query = checkout_params.inject([]){|arr, pair| arr << "#{pair[0]}=#{pair[1]}"}.sort.join("&")
		url.to_s
  end

	private
	  def checkout_params
			replace_line_item_keys literal_params.merge(normalized_params).merge("sid" => SID, "mode" => "2CO")
		end

		def literal_params
			hash = self.attributes.slice(*%w{name price quantity product_type}).inject({}){|hsh, pair| hsh.merge!( pair[0] => pair[1] )}
			hash
		end

		def normalized_params
			params_to_normalize = self.attributes.slice(*%w{demo fixed tangible})
			hash = params_to_normalize.inject({}){|hsh, pair| hsh.merge!( pair[0] => (pair[1] ? "Y" : "N") )}
			hash
		end

		def build_x_receipt_link_url
			u = URI::HTTP.build({:host => Sinatra::Application.bind, :port => Sinatra::Application.port, :path => "/receipts/#{self.id}"})
			self.update_attribute(:x_receipt_link_url, u.to_s)
		end

		def replace_line_item_keys(hash)
			{}.tap do |hsh|
				hash.each_pair do |key, val|
					if new_key = LINE_ITEM_KEYS[key]
						hsh.merge!(new_key => val)
					else
						hsh.merge!(key => val)
					end
				end
			end
		end
end
