require_relative 'board'

module ChessJudge
  def get_king_square(board, white)
    king_square = nil
    (0..7).each do |row_index|
      (0..7).each do |col_index|
        current_square = board.get_square(row_index, col_index)
        piece = current_square.piece
        next if piece.nil?

        king_match = (white == piece.white) && piece.notator == 'K'
        king_square = current_square if king_match
        break unless king_square.nil?
      end
      break unless king_square.nil?
    end
    return king_square
  end

  def find_diag_check(board, king_square, white)
    diag_iters = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diag_iters.each do |step_arr|
      row_iter = king_square.row_index + step_arr[0]
      col_iter = king_square.col_index + step_arr[1]

      while row_iter.between?(0, 7) && col_iter.between?(0, 7) && !board.get_square(row_iter, col_iter).occupied
        row_iter += step_arr[0]
        col_iter += step_arr[1]
      end

      next unless row_iter.between?(0, 7) && col_iter.between?(0, 7)

      diag_piece = board.get_square(row_iter, col_iter).piece
      next unless diag_piece.white != white

      pawn_check =  diag_piece.notator == 'P' &&
                    diag_piece.valid_capture(row_iter, col_iter, king_square.row_index, king_square.col_index)
      bqk_check = diag_piece.valid_move(row_iter, col_iter, king_square.row_index, king_square.col_index)
      return board.get_square(row_iter, col_iter) if pawn_check || bqk_check
    end
    return nil
  end

  def find_knight_check(board, king_square, white)
    rel_knight_steps = [[-2, -1], [-2, 1], [2, -1], [2, 1]]
    rel_knight_steps.each do |knight_step|
      atk_row = king_square.row_index + knight_step[0]
      atk_col = king_square.col_index + knight_step[1]
      next unless atk_row.between?(0, 7) && atk_col.between?(0, 7)
 
      atk_square = board.get_square(atk_row, atk_col)
      if atk_square.occupied
        piece = atk_square.piece
        return board.get_square(atk_row, atk_col) if piece.white != white && piece.notator == 'N'
      end
    end
    return nil
  end

  def find_file_rank_check(board, king_square, white)
    rook_steps = [[-1, 0], [1, 0], [0, -1], [0, 1]]
    rook_steps.each do |rook_step|
      atk_row = king_square.row_index + rook_step[0]
      atk_col = king_square.col_index + rook_step[1]
      while atk_row.between?(0, 7) && atk_col.between?(0, 7) && !board.get_square(atk_row, atk_col).occupied
        atk_row += rook_step[0]
        atk_col += rook_step[1]
      end
      next unless atk_row.between?(0, 7) && atk_col.between?(0, 7)

      atk_piece = board.get_square(atk_row, atk_col).piece
      piece_attacks = atk_piece.white != white && atk_piece.valid_move(atk_row, atk_col, king_square.row_index, king_square.col_index)

      return board.get_square(atk_row, atk_col) if piece_attacks
    end
    return nil
  end

  def check(board, white)
    king_square = get_king_square(board, white)
    diag_check = find_diag_check(board, king_square, white)
    knight_check = find_knight_check(board, king_square, white)
    file_rank_check = find_file_rank_check(board, king_square, white)

    if !diag_check.nil?
      return ['DIAGONAL', diag_check]
    elsif !knight_check.nil?
      return ['KNIGHT', knight_check]
    elsif !file_rank_check.nil?
      return ["FILE/RANK", file_rank_check]
    end

    return nil
  end

end