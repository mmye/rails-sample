class AddAlcoholByVolumeToProductDetails < ActiveRecord::Migration
  def change
    add_column :product_details, :alcohol_by_degree, :string
  end
end
