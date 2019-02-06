class CreateSolidusFbCatalogsTaxons < SolidusSupport::Migration[4.2]
  def self.up
    create_table :spree_fb_catalogs_taxons, id: false do |t|
      t.belongs_to :fb_catalog
      t.belongs_to :taxon
      t.timestamps null: true
    end

    add_index :spree_fb_catalogs_taxons, :fb_catalog_id, name: "fb_catalog_id_spree_fbc_tx"
    add_index :spree_fb_catalogs_taxons, :taxon_id, name: "taxon_id_spree_fbc_tx"

  end

  def self.down
    drop_table :spree_fb_catalogs_taxons
  end
end