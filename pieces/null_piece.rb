require 'singleton'

class NullPiece
  include Singleton
  def to_s
    " "
  end

  def moves
    nil
  end

  def color
    nil
  end

  def valid_move?(_)
    false
  end
end
