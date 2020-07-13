require_relative 'board'
require_relative 'pieces/piece'
require_relative 'pieces/bishop'
require_relative 'pieces/king'
require_relative 'pieces/knight'
require_relative 'pieces/pawn'
require_relative 'pieces/queen'
require_relative 'pieces/rook'

class Player
  attr_accessor :white
  def initialize(white)
    @white = white
  end

  def parse_raw_move(raw_move)
    move_capture = raw_move.include?('x')
    delimeter = move_capture ? 'x' : '-'
    split = raw_move.split(delimeter)
    from = split[0]
    to = split[1]
    piece = 'P'
    file_str = 'abcdefgh'
    if from.length == 3
      piece = from[0].upcase
      from = from[1..2]
    end

    from_col = file_str.index(from[0].downcase)
    from_row = from[1].to_i - 1
    to_col = file_str.index(to[0].downcase)
    to_row = to[1].to_i - 1
    return [piece, move_capture, from_row, from_col, to_row, to_col]
  end

  def get_board_elements(board, piece, capture, from_row, from_col, to_row, to_col)
    from_square = board.get_square(from_row, from_col)
    to_square = board.get_square(to_row, to_col)
    piece_inst = from_square.get_piece
    square_input_mismatch = piece_inst.notator != piece
    move_2_occupied_error = to_square.occupied && !capture
    return nil if square_input_mismatch || move_2_occupied_error

    valid_pawn_capture = capture && piece == 'P' && piece_inst.valid_capture(from_row, from_col, to_row, to_col)
    valid_move = piece_inst.valid_move(from_row, from_col, to_row, to_col)
    return [capture, from_square, to_square] if valid_pawn_capture || valid_move

    return nil
  end

  def request_input(board, msg='')
    puts msg
    puts @white ? 'WHITE TO MOVE' : 'BLACK TO MOVE'
    board.print_self
    valid_input = false
    board_elements = nil
    until valid_input
      print "your move:\t"
      raw_move = gets.chomp
      parsed_elements = parse_raw_move(raw_move)
      board_elements = get_board_elements(board, parsed_elements[0], parsed_elements[1], parsed_elements[2],
                                          parsed_elements[3], parsed_elements[4], parsed_elements[5])
      valid_input = true unless board_elements.nil?
    end
    return board_elements
  end

end
