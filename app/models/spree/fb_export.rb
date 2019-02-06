module Spree
	class FbExport < Spree::Base
		belongs_to :fb_catalog
		serialize :batch_status, Hash
		serialize :products, Array
		validates_presence_of :batch_status
  		validates_presence_of :products
		default_scope { order "created_at desc" }

		def send_products_catalog
			self.batch_status, self.products = batch(self.fb_catalog)
		end
		
	    def update_status
	    	self.batch_status = check_batch_status(self.batch_status[:handle])
	    end

	    def batch(catalog)
	      SolidusFacebookCatalog::ProductCatalog.send_batch(catalog)
	    end

	    def check_batch_status(handle)
	      SolidusFacebookCatalog::ProductCatalog.check_batch_status(handle, self.fb_catalog.catalog_id)
	    end

	end
end
