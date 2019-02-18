namespace :update_facebook_catalogs do
  desc "Update facebook catalogs"
	task update: :environment do
		# puts "Start exports"
		catalogs = Spree::FbCatalog.all
		if catalogs.present?
			catalogs_export = []
		  	catalogs.each do |catalog| 
		  		# puts "Exporting #{catalog.name}" 	
				export = Spree::FbExport.new(created_by: 'System', fb_catalog: catalog)
				export.send_products_catalog
				begin
					export.save				
					catalogs_export << "A catalog #{catalog.name} could be exported - here is the information we have:\n #{export.batch_status[:status]}"
				rescue StandarError => e
					catalogs_export << "A catalog #{catalog.name} could not be exported - here is the information we have:\n #{export.inspect} #{export.errors.full_messages.join(', ')}"
				end
			end
			Spree::UserMailer.fb_catalog_export_results(ENV['fb_send_email_to_user'], catalogs_export).deliver_now
		end
	end
end