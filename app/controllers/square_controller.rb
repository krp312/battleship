class SquareController < ApplicationController
  def update
    g = Game.last

    render plain: 'Wait', status: :ok if g.active_player == 1 && cookies[:player] != 'one'
    render plain: 'Wait', status: :ok if g.active_player == 2 && cookies[:player] != 'two'

    if cookies[:player] == 'one' && g.active_player == 1
      s = Square.find(params[:id])
      s.update(revealed?: true)
      g.update(active_player: 2, status: 'waiting_for_player2')
      render json: s, status: :ok
    elsif cookies[:player] == 'two' && g.active_player == 2
      s = Square.find(params[:id])
      s.update(revealed?: true)
      g.update(active_player: 1, status: 'waiting_for_player1')
      render json: s, status: :ok
    end

    g.game_over
  end
end
