class CreateSquares < ActiveRecord::Migration[5.2]
  def change
    create_table :squares do |t|
      t.integer :position_x, null: false
      t.integer :position_y, null: false
      t.boolean :revealed, default: false, null: false
      t.boolean :player1_ship, default: false, null: false
      t.boolean :player2_ship, default: false, null: false
      t.timestamps
    end
  end
end
