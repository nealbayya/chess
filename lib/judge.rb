require_relative 'board'

module ChessJudge
  def get_king_square(board, white)
    king_square = nil
    (0..7).each do |row_index|
      (0..7).each do |col_index|
        current_square = board.get_square(row_index, col_index)
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

  def find_diag_check(board, king_square, white)
    diag_iters = [[-1, -1], [-1, 1], [1, -1], [1, 1]]
    diag_iters.each_with_index do |step_arr, diag_idx|
      row_iter = king_square.row_index + step_arr[0]
      col_iter = king_square.col_index + step_arr[1]
      n_steps = 1

      while row_iter.between?(0, 7) && col_iter.between?(0, 7) && !board.get_square(row_iter, col_iter).occupied
        row_iter += step_arr[0]
        col_iter += step_arr[1]
        n_steps += 1
      end

      continue unless row_iter.between?(0, 7) && col_iter.between?(0, 7)

      diag_piece = board.get_square(row_iter, col_iter).get_piece
      same_color = diag_piece.white == white
      non_diag_attackor = ['R', 'N', 'K'].include?(diag_piece.notator)
      distant_pawn = diag_piece.notator == 'P' && n_steps > 1
      pawn_dir_mismatch = diag_piece.notator == 'P' && ((white && diag_idx >= 2) || (!white && diag_idx < 2))
      continue if same_color || non_diag_attackor || distant_pawn || pawn_dir_mismatch

      return board.get_square(row_iter, col_iter)
    end
    return nil
  end

  def find_knight_check(board, king_square, white)
    rel_knight_steps = [[-2, -1], [-2, 1], [2, -1], [2, 1]]
    rel_knight_steps.each do |knight_step|
      atk_row = king_square.row_index + knight_step[0]
      atk_col = king_square.col_index + knight_step[1]
      continue unless row_iter.between?(0, 7) && col_iter.between?(0, 7)
 
      atk_square = board.get_square(atk_row, atk_col)
      if atk_square.occupied
        piece = atk_square.get_piece
        return board.get_square(atk_row, atk_col) if atk_piece.white != white && piece.notator == 'N'
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

      continue unless atk_row.between?(0, 7) && atk_col.between?(0, 7)
      atk_piece = board.get_square(atk_row, atk_col).get_piece
      same_color = diag_piece.white == white
      non_rook_attackor = ['R', 'N', 'B', 'P', 'K'].include?(atk_piece.notator)
      continue if same_color || non_rook_attackor

      return board.get_square(atk_row, atk_col)
    end
    retun nil
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