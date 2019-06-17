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

ships = [2, 3, 3, 4, 5]
puts 'PLACING PLAYER 1 SHIPS'
while Square.where(player1_ship: true).count != 17
  cheese = ShipPlacer.new(ships.first, 1).place_ship
  ships.shift if cheese
end

ships = [2, 3, 3, 4, 5]
puts 'PLACING PLAYER 2 SHIPS'
while Square.where(player2_ship: true).count != 17
  cheese = ShipPlacer.new(ships.first, 2).place_ship
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