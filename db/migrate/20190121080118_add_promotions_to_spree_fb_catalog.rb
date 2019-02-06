class AddPromotionsToSpreeFbCatalog < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_fb_catalogs, :promotion_ids, :string
  end
end
