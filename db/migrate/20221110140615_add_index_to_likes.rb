class AddIndexToLikes < ActiveRecord::Migration[5.2]
  def change
    #a user can like/dislike a movie once
    add_index :likes, [:user_id, :movie_id], unique: true
  end
end
