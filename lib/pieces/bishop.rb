require 'piece.rb'

class Bishop < Piece
  def initialize(white)
    super
    @unicode = @white ? "\u2657" : "\u265D"
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super.valid_move(from_row, from_col, to_row, to_col)

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    return row_diff == col_diff || row_diff == -1 * col_diff 
  end
end
