module SolidusFacebookCatalog
  module FbExportMailerExt
    def self.included(base)
      base.class_eval do
        def fb_catalog_export_results(email, catalogs_export)
          @exports = catalogs_export
          @store = Spree::Store.default
          mail(:to => email, :from => from_address(@store), :subject => "Solidus: Facebook Catalog Exports Results")
        end
      end
    end
  end
end