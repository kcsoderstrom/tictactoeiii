class ApplicationController < ActionController::Base
  def play_next_move
    begin
      @board = Board.new(params[:board], true)
    rescue Exception => e
      render json: e.message, status: :bad_request
      return
    end
    @board.place_o!
    render json: @board.to_s
  end
end
