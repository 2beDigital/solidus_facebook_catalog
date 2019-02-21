module Spree
	module Admin
		class FbCatalogsController < ResourceController
			include FacebookFailResponse
			before_action :load_data, only: [:edit]
			before_action :get_promotions, only: [:new, :edit]
			before_action :load_settings, only: [:index]
			before_action :get_catalog_id, only: [:create]
			before_action :update_options, only: [:update]
			before_action :delete_catalog, only: [:destroy]
			before_action :prepare_taxons_params, only: [:create, :update]


			private

			def load_data
				@fb_catalog = Spree::FbCatalog.friendly.find(params[:id])
				@fb_settings = Spree::FbSetting.find_by(store_id: current_store.id)
			end
			def load_settings
				@fb_settings = Spree::FbSetting.find_by(store_id: current_store.id)
			end
			def get_catalog_id
				response = @fb_catalog.get_id(params[:fb_catalog][:name], current_store)
				failed_response(Spree.t(:error_creating_catalog)) unless response
			end
			def update_options
				response = @fb_catalog.update_catalog(params[:fb_catalog][:name])
				failed_response(Spree.t(:error_updating_catalog)) unless response
			end
			def delete_catalog
				response = @fb_catalog.remove
				failed_response(Spree.t(:error_deleting_catalog)) unless response
			end
			def prepare_taxons_params
				if params[:fb_catalog][:taxon_ids].present?
		          params[:fb_catalog][:taxon_ids] = params[:fb_catalog][:taxon_ids].split(',')
		        end
			end
			def get_promotions
				@promotions = Spree::Promotion.where(id: Spree::PromotionRule.where(type: ['Spree::Promotion::Rules::Product','Spree::Promotion::Rules::Taxon']).select(:promotion_id))
			end
		end
	end
end