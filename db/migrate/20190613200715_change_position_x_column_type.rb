class ChangePositionXColumnType < ActiveRecord::Migration[5.2]
  def change
    remove_column :squares, :position_x
    add_column :squares, :position_x, :integer
  end
end
