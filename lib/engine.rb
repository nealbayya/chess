include 'player.rb'
include 'board.rb'
class ChessEngine
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
  end
end