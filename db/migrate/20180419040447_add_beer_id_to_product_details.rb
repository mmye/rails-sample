class AddBeerIdToProductDetails < ActiveRecord::Migration
  def change
    add_column :product_details, :beer_id, :integer
  end
end
