class RemoveProductUrlFromBeeeers < ActiveRecord::Migration
  def change
    remove_column :beeeers, :product_url, :string
  end
end
