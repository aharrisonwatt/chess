class Rook < Piece
  include Slidyable

  def moves
    get_moves(straight_moves)
  end

  def to_s
    if @color == :black
      '♖'
    else
      '♜'
    end
  end
end
