require 'square.rb'
class Board
  def initialize
    @board_array = []
    (1..8).each do |row_index|
      row = []
      light = 1 - row_index % 2
      (1..8).each do |col_index|
        row.push(Square.new(row_index, col_index, light))
        light = 1 - light
      end
      @board_array.push(row)
    end
  end

  def get_square(row_index, col_index)
    return @board_array[row_index][col_index]
  end

end