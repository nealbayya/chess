require_relative 'piece'

class King < Piece
  def initialize(white)
    super
    @unicode = @white ? "\u2654" : "\u265A"
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super.valid_move(from_row, from_col, to_row, to_col)

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    return row_diff.between?(-1, 1) && col_diff.between?(-1, 1)
  end
end
