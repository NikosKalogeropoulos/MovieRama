class AddIndexToTitleAndUserIdInMovies < ActiveRecord::Migration[5.2]
  def change
    add_index :movies, [:title, :user_id], unique: true
  end
end
