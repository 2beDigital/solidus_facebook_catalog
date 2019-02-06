class CreateSolidusFbSettings < SolidusSupport::Migration[4.2]
  def self.up
    create_table :spree_fb_settings do |t|
      t.string :access_token
      t.string :business_id
      t.timestamps
    end
  end

  def self.down
    drop_table :spree_fb_settings
  end
end
