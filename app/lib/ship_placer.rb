# TO DO: player-specific ships
class ShipPlacer
  EAST = { x: 1, y: 0 }.freeze
  SOUTH = { x: 0, y: 1 }.freeze
  WEST = { x: -1, y: 0 }.freeze
  NORTH = { x: 0, y: -1 }.freeze

  def initialize(ship_size, player)
    @random_x = rand(1..10)
    @random_y = rand(1..10)
    @ship_size = ship_size
    @ship_tile_max = @ship_size - 1
    @player_field = player == 1 ? :player1_ship : :player2_ship
  end

  def place_ship
    direction = valid_directions.sample
    return false if direction.nil?

    assign_ship(direction)
    true
  end

  def assign_ship(direction)
    (0..@ship_tile_max).each do |num|
      s = Square.find_by(position_x: @random_x + (direction[:x] * num), position_y: @random_y + (direction[:y] * num))
      s.update!(@player_field => true)
    end
  end

  def direction_clear?(direction)
    (0..@ship_tile_max).each do |num|
      s = Square.find_by(position_x: @random_x + (direction[:x] * num), position_y: @random_y + (direction[:y] * num))
      return false if s.nil?
      return false if s[@player_field] == true
    end
  end

  def valid_directions
    valid_directions = []
    [NORTH, SOUTH, EAST, WEST].each do |direction|
      valid_directions << direction if direction_clear?(direction)
    end
    valid_directions
  end
end