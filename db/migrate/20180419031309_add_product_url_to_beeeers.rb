class AddProductUrlToBeeeers < ActiveRecord::Migration
  def change
    add_column :beeeers, :product_url, :text
  end
end
