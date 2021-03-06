require_relative 'piece'

class Knight < Piece
  def initialize(white)
    super(white)
    @unicode = @white ? "\u2658": "\u265E"
    @notator = 'N'
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super

    abs_row_diff = (to_row - from_row).abs
    abs_col_diff = (to_col - from_col).abs
    return (abs_row_diff == 2 && abs_col_diff == 1) || (abs_row_diff == 1 && abs_col_diff == 2)
  end
end
