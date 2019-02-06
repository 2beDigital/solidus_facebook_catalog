module Spree
	module Admin
		class FbSettingsController < ResourceController
			before_action :load_data, only: [:update, :edit]
			before_action :update_token, only: [:update]
			
			def show
		        redirect_to action: :edit
		    end
			
			private

			def load_data
				@object = Spree::FbSetting.first
			end

			def update_token
				FacebookAds.configure.access_token = params[:fb_setting][:access_token]
			end

		end
	end
end