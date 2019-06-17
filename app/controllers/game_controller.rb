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

  protected

  def assign_players
    if @game.status == 'waiting_for_player1'
      cookies[:player] = 1
      @game.update!(status: 'waiting_for_player2')
    elsif @game.status == 'waiting_for_player2'
      cookies[:player] = 2
      @game.update!(status: 'in_progress')
    end
  end

  def descriptive_status
    check_win_condition
    return 'Player 1 Wins' if @game.status == 'player1_wins'
    return 'Player 2 Wins' if @game.status == 'player2_wins'
    return 'Ready for Move' if @game.active_player?(current_user)
    return 'Please Wait' unless @game.active_player?(current_user)
  end

  def check_win_condition
    if Square.where(revealed: true, player1_ship: true).count == 17
      Game.current.update!(status: 'player2_wins')
    end

    if Square.where(revealed: true, player2_ship: true).count == 17
      Game.current.update!(status: 'player1_wins')
    end
  end
end
