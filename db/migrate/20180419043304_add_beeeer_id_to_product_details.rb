class AddBeeeerIdToProductDetails < ActiveRecord::Migration
  def change
    add_column :product_details, :beeeer_id, :integer
  end
end
