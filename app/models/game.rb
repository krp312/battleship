class Game < ApplicationRecord
  def self.current
    last
  end

  def waiting_for_player_one?
    status == 'waiting_for_player1'
  end

  def waiting_for_player_two?
    status == 'waiting_for_player2'
  end

  def in_progress?
    status == 'in_progress'
  end

  def player1_win
    status == 'player1_wins'
  end

  def player2_win
    status == 'player2_wins'
  end

  def check_game_status
    if Square.where(revealed: true, player1_ship: true).count == 2
      Game.last.update(status: 'player2_wins')
    end

    if Square.where(revealed: true, player2_ship: true).count == 2
      Game.last.update(status: 'player1_wins')
    end
  end

  def active_player?(current_player)
    current_player == active_player
  end

  def active_player_one?
    active_player == 1
  end

  def active_player_two?
    active_player == 2
  end
end
