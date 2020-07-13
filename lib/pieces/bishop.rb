require_relative 'piece'

class Bishop < Piece
  def initialize(white)
    super(white)
    @unicode = @white ? "\u265D" : "\u2657" 
    @notator = 'B'
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    return row_diff == col_diff || row_diff == -1 * col_diff 
  end
end
