class AddProductUrlToBeeeer < ActiveRecord::Migration
  def change
    add_column :beeeers, :product_url, :string
  end
end
