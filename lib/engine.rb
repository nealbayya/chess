require_relative 'player'
require_relative 'board'
class ChessEngine
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
    @move_history = []
  end

  def play_game
    move_num = 1
  end
end