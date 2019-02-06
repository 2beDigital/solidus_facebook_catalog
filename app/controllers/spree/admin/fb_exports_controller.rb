module Spree
	module Admin
		class FbExportsController < ResourceController
			include FacebookFailResponse
			before_action :load_data
			before_action :refresh_token, only: [:send_catalog, :update_catalog_status]

			def send_catalog
				@fb_export = Spree::FbExport.new(created_by: params[:user], fb_catalog: @fb_catalog)
				@fb_export.send_products_catalog
				if @fb_export.save
					flash[:success] = Spree.t(:successfully_sending, resource: Spree.t(:fb_catalog))
				else
					flash[:error] = Spree.t(:fb_catalog_error)
				end
				@collection = Spree::FbExport.where(fb_catalog_id: @fb_catalog.id)
			end

			def update_catalog_status
				@fb_catalog.fb_exports.each do |export|
					if export.batch_status[:status] != 'finished'
						export.update_status
						export.save
					end
				end
				@fb_exports = Spree::FbExport.where(fb_catalog_id: @fb_catalog.id).order(created_at: :desc).page(params[:page]).per(20)
				flash[:success] = Spree.t(:successfully_updated, resource: Spree.t(:fb_exports))
			end

			def edit
				@products = Spree::Product.where(id: @fb_export.products).order(created_at: :desc).page(params[:page]).per(20)
			end

			private

			def load_data
				@fb_catalog = Spree::FbCatalog.friendly.find(params[:fb_catalog_id])
				@fb_exports = @fb_catalog.fb_exports.order(created_at: :desc).page(params[:page]).per(20)
			end
			def refresh_token
		        access_token = SolidusFacebookCatalog::Configure.refresh_access_token
		        if !access_token.blank?
		            FacebookAds.configure.access_token = access_token
		        else
		            failed_response(Spree.t(:fb_access_token_error))
		        end
		    end
		end
	end
end