class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :twitter_handle
      t.text :access_token
      t.text :access_secret
      t.string :user_id
      t.string :img
      t.text :country

      t.timestamps null: false
    end
  end
end
