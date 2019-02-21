module Spree
	module Admin
		class FbSettingsController < ResourceController
			before_action :load_data, except: [:new]
			before_action :update_token, only: [:update]
			def new
				@fb_settings = Spree::FbSetting.new
			end
			def show
	      redirect_to action: :edit
	    end

			private

			def load_data
				@fb_settings = Spree::FbSetting.find_by(store_id: current_store.id)
			end

			def update_token
				FacebookAds.configure.access_token = params[:fb_setting][:access_token]
			end
		end
	end
end