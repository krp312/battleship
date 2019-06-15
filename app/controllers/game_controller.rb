class GameController < ApplicationController
  def index
    @squares = Square.all.order(:id)
    @game = Game.last
    assign_players
    render :index
  end

  def assign_players
    if @game.status == 'waiting_for_player1'
      cookies[:player] = 'one'
      @game.update(status: 'waiting_for_player2')
    elsif @game.status == 'waiting_for_player2'
      cookies[:player] = 'two'
      @game.update(status: 'in_progress')
    end
  end

  def show
    render json: Game.last
  end
end
