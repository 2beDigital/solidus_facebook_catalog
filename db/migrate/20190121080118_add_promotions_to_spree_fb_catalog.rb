class AddPromotionsToSpreeFbCatalog < ActiveRecord::Migration[4.2]
  def change
    add_column :spree_fb_catalogs, :promotion_ids, :string
  end
end
