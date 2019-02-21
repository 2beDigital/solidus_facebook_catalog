module SolidusFacebookCatalog
	class Error < StandardError; end;
	class Configure
	    def self.refresh_access_token
	    	# Update access token 
	    	@fb_settings = Spree::FbSetting.find_by(store_id: current_store.id)
	    	app_id = ENV['FB_app_id']
				app_secret = FacebookAds.configure.app_secret || ENV['FB_app_secret']
				access_token = @fb_settings.present? ? @fb_settings.access_token : FacebookAds.configure.access_token
				redirect_url = ENV['FB_redirect_uri'] || 'https://localhost:3000'
				code = make_call("https://graph.facebook.com/oauth/client_code?access_token=#{access_token}&client_id=#{app_id}&client_secret=#{app_secret}&redirect_uri=#{redirect_url}")["code"]
				new_access_token = make_call("https://graph.facebook.com/oauth/access_token?code=#{code}&client_id=#{app_id}&redirect_uri=#{redirect_url}")["access_token"]
				return new_access_token
	    end

	    def self.make_call(url)
	    	begin
					uri = URI.parse(url)
					response = Net::HTTP.get_response(uri)
					return JSON.parse(response.body)
				rescue StandardError => e
					return false
				end
	    end
	end
end
