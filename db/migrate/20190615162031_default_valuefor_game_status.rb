class DefaultValueforGameStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :games, :status, 'waiting_for_player1'
  end
end
