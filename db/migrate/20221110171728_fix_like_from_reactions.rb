class FixLikeFromReactions < ActiveRecord::Migration[5.2]
  def change
    rename_column :reactions, :like, :type
  end
end
