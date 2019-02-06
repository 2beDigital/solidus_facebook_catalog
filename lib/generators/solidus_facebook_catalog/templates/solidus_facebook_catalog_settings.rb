require 'facebookbusiness'

FacebookAds.configure do |config|
  config.access_token = ENV['FB_access_token']
  config.app_secret = ENV['FB_app_secret']
end