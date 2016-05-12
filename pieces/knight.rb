class Knight < Piece
  include Steppyable

  def to_s
    if @color == :black
      '♘'
    else
      '♞'
    end
  end

  def moves
    current_row, current_col = @pos
    @board.all_pos.reject do |new_row, new_col|
      row_diff = (new_row - current_row).abs
      col_diff = (new_col - current_col).abs
      row_diff > 2 ||
      col_diff > 2 ||
      row_diff + col_diff != 3 ||
      not_takeable?([new_row, new_col])
    end
  end
end
