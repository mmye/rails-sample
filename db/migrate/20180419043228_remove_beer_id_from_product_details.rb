class RemoveBeerIdFromProductDetails < ActiveRecord::Migration
  def change
    remove_column :product_details, :beer_id, :integer
  end
end
