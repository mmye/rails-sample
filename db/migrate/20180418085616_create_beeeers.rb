class CreateBeeeers < ActiveRecord::Migration
  def change
    create_table :beeeers do |t|
      t.string :index
      t.string :item_name
      t.string :image_url
      t.integer :price
      t.integer :price_per_can

      t.timestamps
    end
  end
end
