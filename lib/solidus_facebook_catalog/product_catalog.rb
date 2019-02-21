module SolidusFacebookCatalog
	class Error < StandardError; end;
	class ProductCatalog
		extend Sales if defined?(Sales)
		def self.create_catalog(name,store)
    	business = FacebookAds::Business.get(Spree::FbSetting.find_by(store_id: store.id).business_id)
    	begin
				catalog = business.owned_product_catalogs.create({name: name})
				return catalog.id
			rescue StandardError => e
				return false
			end
	  end

	  def self.update_catalog(id, name)
	    product_catalog = FacebookAds::ProductCatalog.get(id)
			product_catalog.name = name
			begin
				product_catalog.save
			rescue StandardError => e
				return false
			end
    end

    def self.delete_catalog(id)
    	product_catalog = FacebookAds::ProductCatalog.get(id)
    	begin
				product_catalog.delete
			rescue StandardError => e
				return false
			end
	  end

		def self.generate_EAN(number)
			odd_sum = even_sum = 0
			while number.length != 12 do
				if number.length < 12
					number.concat('0')
				else
					number = number.chop
				end
			end
			number.split('').each_with_index do |x,i|
				if i % 2 == 0
					odd_sum += x.to_i
				else
					even_sum += x.to_i * 3
				end
			end	
			total = even_sum  + odd_sum
			check_num = (10 - total % 10) % 10
			return number.concat(check_num.to_s)
		end


		def self.get_sales_price(product)
			sales_price = is_promotionable?(product) ? product.price * ( 100 - percentage(product,product.id) ) / 100 : product.price
			return (sales_price * 100).to_i
		end

		def self.promotionable_products(catalog)
			products, taxons = [],[]
			promotions = Spree::PromotionRule.where(promotion_id: catalog.promotion_ids)
			promotions.each do |p|
				if p.respond_to?(:product_ids)
					products << p.product_ids
				else
					taxons << p.taxon_ids
				end
			end
			return [products.flatten, taxons.flatten]
		end

		def self.get_products(catalog)			
			ids, data, products, taxons = [],[],[],[]
			if catalog.promotion_ids.present?
				products, taxons = promotionable_products(catalog)
				Spree::Taxon.where(id: taxons.uniq).map { |t| products += t.products.ids }
				products = Spree::Product.where(id: products) if products.present?
			end
			if catalog.taxon_ids.present?
				taxons += catalog.taxon_ids
				Spree::Taxon.where(id: taxons.uniq).map { |t| products += t.products }
			elsif products.blank?
				products = Spree::Product.all
			end
			products.uniq.each do |product|
				if product.images.present?
					ids << product.id
					data << {
							method:  'UPDATE',
						    retailer_id: product.sku,
						    data:  {
								availability: (product.master.can_supply? || product.variants.any?{|v| v.can_supply? == true}) ? 'in stock' : 'out of stock',
								category:  product.taxon_ids.map { |x| Spree::Taxon.find_by(id: x).name }.join(' '),
								product_type: product.taxon_ids.map { |x| Spree::Taxon.find_by(id: x).name }.join(' '),
								currency:  Spree::Store.default.default_currency.present? ? Spree::Store.default.default_currency : 'EUR',
								description:  ActionView::Base.full_sanitizer.sanitize(product.description.present? ? product.description : ''),
								image_url:  product.images.first.attachment.url(:original),
								name:  product.name,
								price:  (product.price * 100).to_i,
								sale_price: defined?(Sales) ? get_sales_price(product) : nil,
								url:  "https://#{Spree::Store.default.url.split('/').last}/products/#{product.slug}",
								condition: "new",
								gtin: generate_EAN(product.id.to_s)
					    	}	    	
						}
				end
			end
			return [data, ids]
		end

		def self.send_batch(catalog)
		  @product_catalog = FacebookAds::ProductCatalog.get(catalog.catalog_id)		
			data, ids = get_products(catalog)
			begin
				products = @product_catalog.batch.create({requests: data})
			rescue StandardError => e
				return [{:handle=>"", :status=>"incomplete", :errors_total_count=>'1', :errors=> Spree.t(:error_sending_catalog)}, ids]
			end
			status = @product_catalog.check_batch_request_status(handle: products[:handles].first).to_set
			return [status.first.to_hash, ids]
		end

		def self.check_batch_status(handle, catalog_id)
			@product_catalog = FacebookAds::ProductCatalog.get(catalog_id)
			@product_catalog.check_batch_request_status(handle: handle).to_set.first.to_hash
		end
	end
end