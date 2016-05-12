module Steppyable
  def not_takeable?(new_pos)
    @color == @board[new_pos].color
  end
end
