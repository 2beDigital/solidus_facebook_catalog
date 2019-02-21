module Spree
	class FbCatalog < Spree::Base
		extend FriendlyId
		belongs_to :store
		has_and_belongs_to_many :taxons
		has_many :fb_exports, dependent: :destroy
		validates_presence_of :catalog_id
		validates :catalog_id, uniqueness: true
		serialize :promotion_ids
  	friendly_id :name, use: [:slugged, :finders]

	  def get_id(name,store)
			self.catalog_id = SolidusFacebookCatalog::ProductCatalog.create_catalog(name,store)
		end

		def update_catalog(name)
			SolidusFacebookCatalog::ProductCatalog.update_catalog(self.catalog_id,name)
		end

		def remove
			SolidusFacebookCatalog::ProductCatalog.delete_catalog(self.catalog_id)
		end

	end
end