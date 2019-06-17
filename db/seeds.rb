# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Square.destroy_all
Game.destroy_all

(1..10).each do |i|
  (1..10).each do |j|
    Square.new(position_x: j, position_y: i).save
  end
end

g = Game.new
g.save

Game.last.update(status: 'waiting_for_player1', active_player: 1)

class ShipPlacer
  EAST = { x: 1, y: 0 }.freeze
  SOUTH = { x: 0, y: 1 }.freeze
  WEST = { x: -1, y: 0 }.freeze
  NORTH = { x: 0, y: -1 }.freeze

  def initialize(ship_size)
    @random_x = rand(1..10)
    @random_y = rand(1..10)
    @ship_size = ship_size
    @ship_tile_max = @ship_size - 1
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
      s.update!(player1_ship: true)
    end
  end

  def direction_clear?(direction)
    (0..@ship_tile_max).each do |num|
      s = Square.find_by(position_x: @random_x + (direction[:x] * num), position_y: @random_y + (direction[:y] * num))
      return false if s.nil?
      return false if s.player1_ship == true
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

ships = [2, 3, 3, 4, 5]
while Square.where(player1_ship: true).count != 17
  cheese = ShipPlacer.new(ships.first).place_ship
  ships.shift if cheese
end

# NoMethodError: undefined method `empty?' for nil:NilClass
# /Users/krp/programming/projects/battleship/db/seeds.rb:36:in `place_ship'
# /Users/krp/programming/projects/battleship/db/seeds.rb:178:in `<top (required)>'
# /Users/krp/programming/projects/battleship/bin/rails:9:in `<top (required)>'
# /Users/krp/programming/projects/battleship/bin/spring:15:in `<top (required)>'
# bin/rails:3:in `load'
# bin/rails:3:in `<main>'
# Tasks: TOP => db:seed
# (See full trace by running task with --trace)

# NoMethodError: undefined method `empty?' for nil:NilClass
# /Users/krp/programming/projects/battleship/db/seeds.rb:38:in `place_ship'
# /Users/krp/programming/projects/battleship/db/seeds.rb:121:in `<top (required)>'
# /Users/krp/programming/projects/battleship/bin/rails:9:in `<top (required)>'
# /Users/krp/programming/projects/battleship/bin/spring:15:in `<top (required)>'
# bin/rails:3:in `load'
# bin/rails:3:in `<main>'
# Tasks: TOP => db:seed
# (See full trace by running task with --trace)