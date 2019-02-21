Spree::Store.class_eval do
	has_one :fb_settings, dependent: :destroy
	has_many :fb_catalogs, dependent: :destroy
end