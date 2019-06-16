class SquareController < ApplicationController
  def update
    @game = Game.current
    square = Square.find(params[:id])

    unless active_player_matches?
      render plain: 'Wait', status: :ok
      return
    end

    if active_player_one? 
      @game.update!(active_player: 2, status: 'waiting_for_player2')
    elsif active_player_two?
      @game.update!(active_player: 1, status: 'waiting_for_player1')
    end

    @game.check_game_status
    square.update!(revealed: true)
    render json: square, status: :ok
  end

  def active_player_matches?
    active_player_one? || active_player_two?
  end

  def active_player_one?
    @game.active_player == 1 && cookies[:player] == 'one'
  end

  def active_player_two?
    @game.active_player == 2 && cookies[:player] == 'two'
  end
end
