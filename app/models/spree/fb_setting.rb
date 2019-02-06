module Spree
	class FbSetting < Spree::Base
		validates_presence_of :access_token
  		validates_presence_of :business_id
	end
end