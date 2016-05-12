class Pawn < Piece
  def moved?
    (color == :black && pos[0] != 1) || (color == :white && pos[0] != 6)
  end

  def to_s
    if @color == :black
      '♙'
    else
      '♟'
    end
  end

  def moves
    results = []
    current_row, current_col = pos
    new_row = current_row + move_direction

    if @board.empty?([new_row, current_col])
      results << [new_row, current_col]
      if (moved? == false)
        move_two = [new_row + move_direction, current_col]
        results << move_two unless !@board.empty?(move_two)
      end
    end

    diag_left = [new_row, current_col - 1]
    results << diag_left if @board.in_range?(diag_left) && @board[diag_left].color != @color
    diag_right = [new_row, current_col + 1]
    results << diag_right if @board.in_range?(diag_right) && @board[diag_right].color != @color
    results
  end

  def move_direction
    color == :white ? -1 : 1
  end

  def dup
    super
  end
end
