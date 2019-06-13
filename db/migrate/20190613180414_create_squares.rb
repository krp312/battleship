class CreateSquares < ActiveRecord::Migration[5.2]
  def change
    create_table :squares do |t|
      t.string :position_x
      t.integer :position_y
      t.boolean :revealed?
      t.boolean :player1_ship?
      t.boolean :player2_ship?
      t.timestamps
    end
  end
end
