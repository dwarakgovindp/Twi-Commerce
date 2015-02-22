class CreateAdvertisements < ActiveRecord::Migration
  def change
    create_table :advertisements do |t|
      t.string :twitter_handle
      t.string :country
      t.string :img
      t.string :prod_img
      t.text :spec
      t.string :quoted_price
      t.string :category
      t.timestamp :posted_at

      t.timestamps null: false
    end
  end
end
