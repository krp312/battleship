class Player1GoesFirst < ActiveRecord::Migration[5.2]
  def change
    remove_column :games, :active_player
    add_column :games, :active_player, :integer, default: 1
  end
end
