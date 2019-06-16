class CreateGames < ActiveRecord::Migration[5.2]
  def change
    create_table :games do |t|
      t.integer :active_player, default: 1, null: false
      t.string :status, default: 'waiting_for_player1', null: false
      t.timestamps
    end
  end
end
