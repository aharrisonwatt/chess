class HumanPlayer
  attr_reader :color

  def initialize(name, board, color)
    @name = name
    @display = Display.new(board)
    @color = color
  end
  
  def get_move
      result = nil
      until result
        @display.render
        puts "#{@name} it is your turn"
        result = @display.get_input
      end
      result
  end
end
