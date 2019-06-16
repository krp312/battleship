class SquareController < ApplicationController
  def update
    @game = Game.current
    square = Square.find(params[:id])

    unless @game.active_player?(current_user)
      render plain: 'Wait', status: :ok
      return
    end

    if @game.active_player_one?
      @game.update!(active_player: 2, status: 'waiting_for_player2')
    elsif @game.active_player_two?
      @game.update!(active_player: 1, status: 'waiting_for_player1')
    end

    @game.check_game_status
    square.update!(revealed: true)
    render json: square, status: :ok
  end
end
