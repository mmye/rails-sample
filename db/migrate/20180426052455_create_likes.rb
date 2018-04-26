class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.references :beeeer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
