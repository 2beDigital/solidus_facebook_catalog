class AddReferencesToStore < ActiveRecord::Migration[5.0]
  def change
    add_reference :spree_fb_settings, :store
    add_reference :spree_fb_catalogs, :store
  end
end