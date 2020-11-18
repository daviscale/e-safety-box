class RemoveEncryptedFromWebsites < ActiveRecord::Migration
  def change
    remove_column :websites, :encrypted, :boolean
  end
end
