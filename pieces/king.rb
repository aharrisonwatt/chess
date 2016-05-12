class King < Piece
  include Steppyable

  def to_s
    if @color == :black
      '♔'
    else
      '♚'
    end
  end

  def moves
    current_row, current_col = pos
    @board.all_pos.reject do |x,y|
      (x - current_row).abs > 1 ||
      (y - current_col).abs > 1 ||
      (x == current_row && y == current_col) ||
      not_takeable?([x,y])
    end
  end
end
