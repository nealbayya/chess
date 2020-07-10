require_all 'pieces/'
class Square
  attr_reader :row_index, :col_index, :occupied, :piece, :light
  def initialize(row_index, col_index, light)
    @row_index = row_index 
    @col_index = col_index
    @occupied = false
    @piece = nil
    @light = light
  end

  def detatch_piece
    if @occupied
      @occupied = false
      @detatched_piece = @piece
      @piece = nil 
      return @detatched_piece
    end
    return nil
  end

  def place_piece(piece)
    if @occupied
      raise "Square is not empty"
    end
    @occupied = true
    @piece = Piece
  end

end
