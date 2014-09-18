require 'colorize'

class Piece

  attr_reader :color

  def initialize(board, position, color)
    @board = board
    @color = color
    board[position] = self
  end

  def perform_slide

  end

  def perform_jump

  end

  def display
    case self.color
    when :red
      print "*".red.on_white
    when :white
      print "*".black.on_white
    end
  end

end