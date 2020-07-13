require_relative 'pieces/piece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

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
      raise 'Square is not empty'
    end
    @occupied = true
    @piece = piece
  end

  def get_piece
    return @piece if @occupied
    
    return nil
  end  

end
