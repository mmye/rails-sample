class HashtagsBeeeers < ActiveRecord::Migration
  def change
    create_table :hashtags_beeeers do |t|
      t.references :hashtag, index: true, foreign_key: true
      t.references :beeeer, index: true, foreign_key: true
      t.timestamps
    end
  end
end
