require_relative 'piece'

class Queen < Piece
  def initialize(white)
    super(white)
    @unicode = @white ? "\u265B" : "\u2655"
    @notator = 'Q'
  end

  def valid_move(from_row, from_col, to_row, to_col)
    return false unless super.valid_move(from_row, from_col, to_row, to_col)

    row_diff = to_row - from_row
    col_diff = to_col - from_col
    diag_move = row_diff == col_diff || row_diff == -1 * col_diff
    rank_move = row_diff.zero? || col_diff.zero?
    return diag_move || rank_move
  end
end
