class AddSlugToSpreeFbCatalogs < ActiveRecord::Migration[5.0]
  def change
    add_column :spree_fb_catalogs, :slug, :string
    add_index :spree_fb_catalogs, :slug, unique: true
  end
end
