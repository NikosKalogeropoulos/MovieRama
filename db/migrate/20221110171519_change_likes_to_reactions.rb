class ChangeLikesToReactions < ActiveRecord::Migration[5.2]
  def change
    rename_table :likes, :reactions
  end
end
