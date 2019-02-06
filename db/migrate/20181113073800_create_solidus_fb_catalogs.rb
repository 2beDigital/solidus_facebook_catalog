class CreateSolidusFbCatalogs < SolidusSupport::Migration[4.2]
  def self.up
    create_table :spree_fb_catalogs do |t|
      t.string :created_by
      t.string :catalog_id
      t.string :name
      t.timestamps
    end

    add_index :spree_fb_catalogs, [:name],  name: 'index_spree_fb_catalogs_on_name'
  end

  def self.down
    drop_table :spree_fb_catalogs
  end
end