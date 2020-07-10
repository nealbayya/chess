require_relative 'piece'

class Rook < Piece
  def initialize(white)
    super(white)
    @unicode = white ? "\u265C" : "\u2656"
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super.valid_move(from_row, from_col, to_row, to_col)

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    return row_diff.zero? || col_diff.zero?
  end
end
