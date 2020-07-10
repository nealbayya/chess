class Piece
  attr_accessor :white, :unicode
  def initialize(white)
    @white = white
    @unicode = ""
  end

  def valid_move(from_row, from_col, to_row, to_col)
    on_board = ->(x) { x.between?(0, 7) }
    return on_board.call(from_row) && on_board.call(from_col) && on_board.call(to_row) && on_board.call(to_col)
  end
end