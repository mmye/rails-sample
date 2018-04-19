class CreateProductDetails < ActiveRecord::Migration
  def change
    create_table :product_details do |t|
      t.string :brand
      t.string :manufacturer_name
      t.string :package_type
      t.string :package_dim
      t.string :weight
      t.string :origin
      t.text   :description

      t.timestamps
    end
  end
end
