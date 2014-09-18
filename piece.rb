require 'colorize'

class Piece

  attr_reader :color

  def inspect
    "#{self.color} piece"
  end

  def initialize(board, position, color)
    @board = board
    @color = color
    board[position] = self
    @is_king = false
  end

  def perform_slide

  end

  def perform_jump

  end

  def king_me
    @is_king = true
  end

  def king?
    @is_king
  end

  def display
    case self.color
    when :red
      print "*".red.on_white
    when :white
      print "*".black.on_white
    end
  end

  private

  def move_diffs
    direction = {red: 1,   black: -1}[self.color]
    diffs = [[-1, direction], [1, direction]]
    if king?
      diffs += [[-1, -direction], [1, -direction]]
    end

    diffs
  end

  def opponent
    self.color == :red ? :black : :red
  end


end

