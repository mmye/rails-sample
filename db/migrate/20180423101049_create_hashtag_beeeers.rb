class CreateHashtagBeeeers < ActiveRecord::Migration
  def change
    create_table :hashtag_beeeers do |t|
      t.references :hashtag, index: true, foreign_key: true
      t.references :beeeer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
