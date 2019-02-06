class CreateSolidusFbExports < SolidusSupport::Migration[4.2]
  def self.up
    create_table :spree_fb_exports do |t|
      t.belongs_to :fb_catalog, index: true
      t.text :batch_status,   limit: 4294967295
      t.text :products
      t.string :created_by
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_fb_exports
  end
end