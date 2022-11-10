class FixColumnTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :reactions, :type, :ttype
  end
end
