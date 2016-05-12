module Slidyable
  def straight_moves
    vertical_moves + horizontal_moves
  end

  def vertical_moves
    current_row, current_col = @pos
    @board.all_pos.select do |x,y|
      y == current_col && x != current_row
    end
  end

  def horizontal_moves
    current_row, current_col = @pos
    @board.all_pos.select do |x,y|
      x == current_row && y != current_col
    end
  end

  def diagonal_moves
    current_row, current_col = @pos
    @board.all_pos.select do |x,y|
      ((current_row - x).abs == (current_col - y).abs) &&
      !(x == current_row && y == current_col)
    end
  end

  def piece_between?(new_pos)
    current_row, current_col = @pos
    new_row, new_col = new_pos
    #move new_row/col one set closer to @pos
    new_row += (current_row <=> new_row)
    new_col += (current_col <=> new_col)
    #no piece between if they == to eachother
    return false if [new_row, new_col] == @pos
    #recursive call
    if @board.empty?([new_row, new_col])
      piece_between?([new_row, new_col])
    else
      true
    end
  end

  def not_takeable?(new_pos)
    @color == @board[new_pos].color
  end

  def get_moves(moves)
    moves.reject do |pos|
      not_takeable?(pos) || piece_between?(pos)
    end
  end
end
