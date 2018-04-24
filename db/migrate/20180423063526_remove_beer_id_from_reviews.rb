class RemoveBeerIdFromReviews < ActiveRecord::Migration
  def change
    remove_column :reviews, :beer_id, :integer
  end
end
