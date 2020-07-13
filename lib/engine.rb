require_relative 'player'
require_relative 'board'
require_relative 'judge'
class ChessEngine
  include 
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
    @move_history = []
  end

  def play 
    move_num = 1

  end
end