class RemoveIndexFromBeeeer < ActiveRecord::Migration
  def change
    remove_column :beeeers, :index, :integer
  end
end
