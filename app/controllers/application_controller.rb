class ApplicationController < ActionController::Base
  def play_next_move
    @board = Board.new(params[:board])
    @board.place_o!
    render json: @board.to_s
  end
end
