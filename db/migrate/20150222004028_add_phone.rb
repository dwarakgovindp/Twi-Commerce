class AddPhone < ActiveRecord::Migration
  def change
  	add_column :advertisements, :phone, :string
  end
end
