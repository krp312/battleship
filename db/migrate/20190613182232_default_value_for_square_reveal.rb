class DefaultValueForSquareReveal < ActiveRecord::Migration[5.2]
  def change
    change_column_default :squares, :revealed?, false
  end
end
