class AddColumnPostIdStringToAdvertisement < ActiveRecord::Migration
  def change
  	add_column :advertisements, :post_id, :string
  end
end
