require_relative 'player'
require_relative 'board'
class ChessEngine
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
  end
end