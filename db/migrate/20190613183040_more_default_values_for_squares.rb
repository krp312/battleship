class MoreDefaultValuesForSquares < ActiveRecord::Migration[5.2]
  def change
    change_column_default :squares, :player1_ship?, false
    change_column_default :squares, :player2_ship?, false
  end
end
