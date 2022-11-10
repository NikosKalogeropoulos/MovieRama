class CreateLikes < ActiveRecord::Migration[5.2]
  def change
    create_table :likes do |t|
      t.boolean :like, null: false
      t.references :user, foreign_key: {to_table: 'users'}, null: false, index: true
      t.references :movie, foreign_key: {to_table: 'movies'}, null: false, index: true
      t.timestamps
    end
  end
end
