class CreateIpWhitelists < ActiveRecord::Migration
  def change
    create_table :ip_whitelists do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
