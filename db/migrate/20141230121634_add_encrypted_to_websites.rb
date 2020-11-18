class AddEncryptedToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :encrypted, :boolean, default: false
  end
end
