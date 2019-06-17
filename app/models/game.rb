class Game < ApplicationRecord
  def self.current
    last
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
