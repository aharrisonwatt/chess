require_relative 'board'
require_relative 'display'
require_relative 'human_player'
require 'byebug'

class Game
  include Cursorable

  def initialize
    @board = Board.new

    @player1 = HumanPlayer.new("player1", @board, :white)
    @player2 = HumanPlayer.new("player2", @board, :black)
    @current_player = @player1
  end

  def play
    until @board.checkmate?(@current_player.color)
      play_turn
      switch_player!
    end
  end

  def play_turn
    begin
      start_pos = @current_player.get_move
      end_pos = @current_player.get_move
      unless @board[start_pos].color == @current_player.color
        raise ArgumentError.new("that's not yo piece!")
      end
      @board.move(start_pos, end_pos)
    rescue StandardError => e
      puts e.message
      retry
    end
  end

  def switch_player!
  @current_player = (@current_player == @player1 ? @player2 : @player1)
  end
end

if __FILE__==$0
  Game.new.play
end
