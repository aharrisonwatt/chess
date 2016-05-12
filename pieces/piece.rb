class Piece
  attr_accessor :pos
  attr_reader :color

  def initialize(board, pos, color)
     @board = board
     @pos = pos
     @color = color
  end

  def valid_move?(end_pos)
    moves.include?(end_pos) && !@board.in_check?(@color)
  end

  def valid_moves
     moves.reject { |new_pos| move_into_check?(new_pos) }
  end

  def move_into_check?(new_pos)
    test_board = @board.dup
    test_board.move!(pos, new_pos)
    test_board.in_check?(color)
  end
end
