require_relative 'piece'

class King < Piece
  def initialize(white)
    super(white)
    @unicode = @white ? "\u265A": "\u2654"
    @notator = 'K'
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    return row_diff.between?(-1, 1) && col_diff.between?(-1, 1)
  end
end
