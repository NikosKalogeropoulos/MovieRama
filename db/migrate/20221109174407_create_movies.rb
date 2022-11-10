class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title, null: false, index: true
      t.string :description, null: false
      t.references :user, foreign_key: {to_table: 'users'}, null: false, index: true
      t.timestamps
    end
  end
end
