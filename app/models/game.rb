class Game < ApplicationRecord
  def self.current
    last
  end

  def check_game_status
    if Square.where(revealed: true, player1_ship: true).count == 2
      Game.last.update(status: 'player2_wins')
    end

    if Square.where(revealed: true, player2_ship: true).count == 2
      Game.last.update(status: 'player1_wins')
    end
  end
end
