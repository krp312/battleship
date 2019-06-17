require 'rails_helper'

describe ShipPlacer do
  subject { ShipPlacer.new(2, 1) }

  describe '#assign_ship' do
    it 'given a cardinal direction, places a ship' do
      square1 = FactoryBot.create(:square, position_x: 0, position_y: 0)
      square2 = FactoryBot.create(:square, position_x: 1, position_y: 0)
      subject.instance_variable_set(:@random_x, 0)
      subject.instance_variable_set(:@random_y, 0)
      subject.assign_ship(ShipPlacer::EAST)

      expect(square1.reload.player1_ship).to be true
      expect(square2.reload.player1_ship).to be true
    end
  end

  describe '#direction_clear?' do
    it 'given a cardinal direction, checks if a ship can be placed' do
      FactoryBot.create(:square, position_x: 0, position_y: 0)
      FactoryBot.create(:square, position_x: 1, position_y: 0)
      subject.instance_variable_set(:@random_x, 0)
      subject.instance_variable_set(:@random_y, 0)

      expect(subject.direction_clear?(ShipPlacer::EAST)).to be true
    end

    it 'will detect if a ship will not fit on the game board' do
      FactoryBot.create(:square, position_x: 0, position_y: 0)
      FactoryBot.create(:square, position_x: 1, position_y: 0)
      subject.instance_variable_set(:@random_x, 1)
      subject.instance_variable_set(:@random_y, 0)

      expect(subject.direction_clear?(ShipPlacer::EAST)).to be false
    end

    it 'will detect if a tile is already occupied by a ship' do
      FactoryBot.create(:square, position_x: 0, position_y: 0)
      FactoryBot.create(:square, position_x: 1, position_y: 0, player1_ship: true)
      subject.instance_variable_set(:@random_x, 0)
      subject.instance_variable_set(:@random_y, 0)

      expect(subject.direction_clear?(ShipPlacer::EAST)).to be false
    end
  end
end
