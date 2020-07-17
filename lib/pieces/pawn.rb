require_relative 'piece'

class Pawn < Piece
  def initialize(white)
    super(white)
    @unicode = @white ? "\u2659": "\u265F"
    @notator = 'P'
  end

  def valid_move(from_row, from_col, to_row, to_col)
    #cannot move off board or move across columns (unless capture)
    return false unless super
    return false unless from_col == to_col
    
    #2 square push from beginning pawn row
    return true if @white && from_row == 1 && to_row == 3
    return true if !@white && from_row == 6 && to_row == 4

    #1 square push otherwise
    return true if @white && (to_row == (from_row + 1))
    return true if !@white && (to_row == (from_row - 1))

    return false
  end

  def valid_capture(from_row, from_col, to_row, to_col)
    return true if @white && (to_col - from_col).abs() == 1 && (to_row - from_row) == 1
    return true if !@white && (to_col - from_col).abs() == 1 && (from_row - to_row) == 1
    return false
  end

end
