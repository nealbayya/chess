require 'square.rb'
require_all 'pieces/'

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
    setup_pieces
  end

  def setup_pieces
    @board_array[0][0].place_piece(Rook.new(true))
    @board_array[0][1].place_piece(Knight.new(true))
    @board_array[0][2].place_piece(Bishop.new(true))
    @board_array[0][3].place_piece(Queen.new(true))
    @board_array[0][4].place_piece(King.new(true))
    @board_array[0][5].place_piece(Bishop.new(true))
    @board_array[0][6].place_piece(Knight.new(true))
    @board_array[0][7].place_piece(Rook.new(true))

    (0..7).each do |col|
      @board_array[1][col].place_piece(Pawn.new(true))
      @board_array[6][col].place_piece(Pawn.new(false))
    end

    @board_array[7][0].place_piece(Rook.new(false))
    @board_array[7][1].place_piece(Knight.new(false))
    @board_array[7][2].place_piece(Bishop.new(false))
    @board_array[7][3].place_piece(Queen.new(false))
    @board_array[7][4].place_piece(King.new(false))
    @board_array[7][5].place_piece(Bishop.new(false))
    @board_array[7][6].place_piece(Knight.new(false))
    @board_array[7][7].place_piece(Rook.new(false))
  end

  def get_square(row_index, col_index)
    return @board_array[row_index][col_index]
  end

  def print_board
    (7..0).each do |row|
      (0..7).each do |col|
        print @board_array[row][col].get_piece.unicode.encode('utf-8') + ' '
      end
      print "\n"
    end
  end

end