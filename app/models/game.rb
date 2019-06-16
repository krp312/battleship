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
