require_relative 'pieces.rb'

class Board
  def initialize(fill = true)
    @grid = Array.new(8) {Array.new(8) { NullPiece.instance }}
    populate_grid if fill
  end


  def move(start, end_pos)
    if self[start].valid_move?(end_pos)
      move!(start, end_pos)
    else
      raise StandardError.new("BAD MOVE")
    end
  end

  def move!(start, end_pos)
    piece = self[start]
    piece.pos = end_pos
    self[end_pos] = piece
    self[start] = NullPiece.instance
  end

  def populate_grid
    place_pieces(:white)
    place_pieces(:black)
  end

  def place_piece(pos, piece_type, color)
    self[pos] = piece_type.new(self, pos, color)
  end

  def dup
    new_board = Board.new(false)
    pieces.each do |piece|
      new_board.place_piece(piece.pos, piece.class, piece.color)
    end
  end

  def pieces
    all_pos.reject { |pos| self.empty?(pos) }.map {|pos| self[pos]}
  end

  def place_pieces(color)
    place_pawns(color)
    place_base_row(color)
  end

  def place_pawns(color)
    color == :black ? row = 1 : row = 6
    @grid[row].each_index do |col|
      place_piece([row, col], Pawn, color)
    end
  end

  def place_base_row(color)
    color == :black ? row = 0 : row = 7
    #Rooks
    [0,7].each { |col| place_piece([row,col], Rook, color) }
    #Knights
    [1,6].each { |col| place_piece([row,col], Knight, color)}
    #Bishops
    [2,5].each { |col| place_piece([row,col], Bishop, color) }
    #Queen
    place_piece([row,3], Queen, color)
    #King
    place_piece([row,4], King, color)
  end

  def rows
    @grid
  end
  def find_king(color)
    all_pos.select do |pos|
      self[pos].is_a?(King) && self[pos].color == color
    end.first.flatten
  end

  def in_check?(color)
    king_pos = find_king(color)
    color == :white ? check_color = :black : check_color = :white
    all_pieces(check_color).any? do |piece|
      piece.valid_moves.include?(king_pos)
    end
  end

  def all_pieces(color)
    all_pos.select {|pos| self[pos].color == color}.map do |pos|
      self[pos]
    end
  end

  def checkmate?
    false
  end
  def in_range?(pos)
    x, y = pos
    (0...@grid.size).include?(x) && (0...@grid.size).include?(y)
  end

  def all_pos
    indices = (0...@grid.size).to_a
    indices.product(indices)
  end

  def empty?(pos)
    self[pos] == NullPiece.instance
  end
  # private
  def [](pos)
    row,col = pos
    @grid[row][col]
  end

  def []=(pos, piece)
    row,col = pos
    @grid[row][col] = piece
  end
