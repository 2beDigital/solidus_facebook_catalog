module Spree
	class FbSetting < Spree::Base
		belongs_to :store
		validates_presence_of :access_token
  	validates_presence_of :business_id
	end
end