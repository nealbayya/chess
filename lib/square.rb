require_all 'pieces/'
class Square
  attr_accessor :row_index, :col_index, :occupied, :piece, :light
  def initialize(row_index, col_index, light)
    @row_index = row_index 
    @col_index = col_index
    @occupied = false
    @piece = nil
    @light = light
  end
end