class RemoveAlcholByVolumeFromBeeeers < ActiveRecord::Migration
  def change
    remove_column :beeeers, :alchol_by_degree, :string
  end
end
