class FixColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :reactions, :type, :string
  end
end
