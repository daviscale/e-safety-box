class CreateWebsites < ActiveRecord::Migration
  def change
    create_table :websites do |t|
      t.string :name
      t.string :username
      t.string :password
      t.text :notes

      t.timestamps
    end
  end
end
