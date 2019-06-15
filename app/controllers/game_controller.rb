class GameController < ApplicationController
  def index
    @squares = Square.all.order(:id)
    render :index
  end
end
