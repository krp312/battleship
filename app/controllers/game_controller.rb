class GameController < ApplicationController
  def index
    @squares = Square.all.order(:id)
    @game = Game.current
    assign_players
    render :index
  end

  def show
    @game = Game.current
    render json: @game.attributes.merge(descriptive_status: descriptive_status)
  end

  protected # TO DO (vs. private)

  def assign_players
    if @game.status == 'waiting_for_player1'
      cookies[:player] = 1
      @game.update(status: 'waiting_for_player2')
    elsif @game.status == 'waiting_for_player2'
      cookies[:player] = 2
      @game.update(status: 'in_progress')
    end
  end

  def descriptive_status
    return 'Ready for Move' if @game.active_player?(current_user)
    return 'Please Wait' unless @game.active_player?(current_user)
    return 'Player 1 Wins' if @game.player1_win
    return 'Player 2 Wins' if @game.player2_win
  end
end
