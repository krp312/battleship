Square.destroy_all
Game.destroy_all

(1..10).each do |i|
  (1..10).each do |j|
    Square.create!(position_x: j, position_y: i)
  end
end

Game.create!(status: 'waiting_for_player1', active_player: 1)

ships = [2, 3, 3, 4, 5]
while Square.where(player1_ship: true).count != 17
  ship_placed = ShipPlacer.new(ships.first, 1).place_ship
  ships.shift if ship_placed
end

ships = [2, 3, 3, 4, 5]
while Square.where(player2_ship: true).count != 17
  ship_placed = ShipPlacer.new(ships.first, 2).place_ship
  ships.shift if ship_placed
end
