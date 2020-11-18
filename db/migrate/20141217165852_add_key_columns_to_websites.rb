class AddKeyColumnsToWebsites < ActiveRecord::Migration
  def change
    add_column :websites, :key_uuid, :string
    add_column :websites, :key_index, :integer
  end
end
