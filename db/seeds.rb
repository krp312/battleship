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

Square.first.update(player1_ship: true)
Square.second.update(player1_ship: true)
Square.third.update(player2_ship: true)
Square.fourth.update(player2_ship: true)
