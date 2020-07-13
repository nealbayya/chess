require_relative 'player'
require_relative 'board'
require_relative 'judge'
class ChessEngine
  include ChessJudge
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
    @move_history = []
  end


  def play_move(white)
    player = white ? @white_player : @black_player
    first_request = true
    in_check = true
    while check
      msg = first_request ? '' : 'INVALID MOVE [CHECK]'
      move_arr = player.request_input(@board, msg)
      first_request = false
      capture = move_arr[0]
      from_square = move_arr[1]
      to_square = move_arr[2]
      piece = from_square.detatch_piece
      captured_piece = capture ? to_square.detatch_piece : nil
      to_square.place_piece(piece)
      in_check = check(@board, white)
      if in_check  
        from_square.place_piece(piece)
        if captured
          to_square.place_piece(captured_piece)
        end
      end
    end

  end

  def play
    move_num = 1
    white_check_mtd = false
    black_check_mtd = false

    until white_check_mtd || black_check_mtd
      play_move(true)
      play_move(false)
      move_num += 1
    end
  end
  
end