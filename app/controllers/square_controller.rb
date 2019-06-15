class SquareController < ApplicationController
  def update
    s = Square.find(params[:id])
    s.update(revealed?: true)
    render json: s, status: :ok
  end
end
