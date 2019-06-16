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
    Square.new(position_x: i, position_y: j).save
  end
end

g = Game.new
g.save

Game.last.update(status: 'waiting_for_player1', active_player: 1)

# Square.second.update(player1_ship: true)
# Square.where(position_x: 1, position_y: 9).update(player1_ship: true)

class ShipPlacer
  def initialize(ship_size)
    @random_x = random_x
    @random_y = random_y
    @ship_size = ship_size
    @ship_tile_max = @ship_size - 1
  end

  def place_ship
    direction = preexisting_ship_test(overflow_test).sample
    return false if direction.empty?

    if direction == 'east'
      (0..@ship_tile_max).each do |num|
        Square.where(position_x: @random_x, position_y: @random_y + num).first.update(player1_ship: true)
      end
    end

    if direction == 'south'
      (0..@ship_tile_max).each do |num|
        Square.where(position_x: @random_x + num, position_y: @random_y).first.update(player1_ship: true)
      end
    end

    if direction == 'west'
      (0..@ship_tile_max).each do |num|
        Square.where(position_x: @random_x, position_y: @random_y - num).first.update(player1_ship: true)
      end
    end

    if direction == 'north'
      (0..@ship_tile_max).each do |num|
        Square.where(position_x: @random_x - num, position_y: @random_y).first.update(player1_ship: true)
      end
    end

    true
  end

  def preexisting_ship_test(cardinal_directions)
    valid_directions = []
    cardinal_directions.each do |direction|
      valid_directions << direction unless send("#{direction}_ships_exist?")
    end
    valid_directions
  end

  def east_ships_exist?
    (0..@ship_tile_max).each do |num|
      s = Square.where(position_x: @random_x, position_y: @random_y + num).first
      return true if s.player1_ship == true
    end

    false
  end

  def south_ships_exist?
    (0..@ship_tile_max).each do |num|
      s = Square.where(position_x: @random_x + num, position_y: @random_y).first
      return true if s.player1_ship == true
    end

    false
  end

  def west_ships_exist?
    (0..@ship_tile_max).each do |num|
      s = Square.where(position_x: @random_x, position_y: @random_y - num).first
      return true if s.player1_ship == true
    end

    false
  end

  def north_ships_exist?
    (0..@ship_tile_max).each do |num|
      s = Square.where(position_x: @random_x - num, position_y: @random_y).first
      return true if s.player1_ship == true
    end

    false
  end

  def overflow_test
    valid_directions = []
    valid_directions << 'east' unless east_overflow?
    valid_directions << 'south' unless south_overflow?
    valid_directions << 'west' unless west_overflow?
    valid_directions << 'north' unless north_overflow?
    valid_directions
  end

  def east_overflow?
    ship_end = @random_y + @ship_tile_max
    return true if ship_end < 1 || ship_end > 10

    false
  end

  def south_overflow?
    ship_end = @random_x + @ship_tile_max
    return true if ship_end < 1 || ship_end > 10

    false
  end

  def west_overflow?
    ship_end = @random_y - @ship_tile_max
    return true if ship_end < 1 || ship_end > 10

    false
  end

  def north_overflow?
    ship_end = @random_x - @ship_tile_max
    return true if ship_end < 1 || ship_end > 10

    false
  end

  protected

  def random_x
    rand(1..10)
  end

  def random_y
    rand(1..10)
  end
end

ships = [2,3,3,4,5]
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