class AddBeeeerIdToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :beeeer_id, :integer
  end
end
