require_relative 'player'
require_relative 'board'
class ChessEngine
  def initialize
    @board = Board.new
    @white_player = Player.new(true)
    @black_player = Player.new(false)
    @move_history = []
  end

  def get_king_square(white)
    king_square = nil
    (0..7).each do |row_index|
      (0..7).each do |col_index|
        current_square = @board.get_square(row_index, col_index)
        piece = current_square.get_piece
        continue if piece.nil?
        white_king_match = white && piece.white && piece.notator == 'K'
        black_king_match = !white && !piece.white && piece.notator == 'K'
        king_square = current_square if white_king_match || black_king_match
        break unless king_square.nil?
      end
      break unless king_square.nil?
    end
    return king_square
  end

  def diag_check(king_square, white)
    diag_iters = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diag_iters.each_with_index do |step_arr, diag_idx|
      row_iter = king_square.row_index + step_arr[0]
      col_iter = king_square.col_index + step_arr[1]
      n_steps = 1

      while row_iter.between?(0, 7) && col_iter.between?(0, 7) && !@board.get_square(row_iter, col_iter).occupied
        row_iter += step_arr[0]
        col_iter += step_arr[1]
        n_steps += 1
      end

      continue unless row_iter.between?(0, 7) && col_iter.between?(0, 7)

      diag_piece = @board.get_square(row_iter, col_iter).get_piece
      same_color = diag_piece.white == white
      non_diag_attackor = ['N', 'K'].include?(diag_piece.notator)
      distant_pawn = diag_piece.notator == 'P' && n_steps > 1
      pawn_dir_mismatch = diag_piece.notator == 'P' && ((white && diag_idx >= 2) || (!white && diag_idx < 2))
      continue if same_color || non_diag_attackor || distant_pawn || pawn_dir_mismatch

      return @board.get_square(row_iter, col_iter)
    end
    return nil
  end

  def knight_check(king_square, white)
    
  end

  def file_rank_check(king_square, white)
  end



  def check(white)
    king_square = get_king_square(white)

  end
end