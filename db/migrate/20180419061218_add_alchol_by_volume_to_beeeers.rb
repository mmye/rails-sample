class AddAlcholByVolumeToBeeeers < ActiveRecord::Migration
  def change
    add_column :beeeers, :alchol_by_degree, :string
  end
end
