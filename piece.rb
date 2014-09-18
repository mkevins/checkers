require 'colorize'

class Piece

  UP, DOWN, LEFT, RIGHT = -1, 1, -1, 1
  DELTAS = {
    red: [[LEFT, DOWN], [RIGHT, DOWN]],
    black: [[LEFT, UP], [RIGHT, UP]]
  }

  attr_reader :board, :position, :color

  def inspect
    "#{self.color} piece"
  end

  def initialize(board, position, color)
    @board = board
    @color = color
    self.position = position
    @is_king = false
  end

  def position=(new_position)
    self.board[self.position] = nil unless self.position == nil# pick up piece
    @position = new_position # tell it where it belongs
    self.board[new_position] = self # put it there
  end

  def perform_slide(position)
    return false unless self.board[position].nil?
    if possible_slides.include?(position)
      self.position = position
      return true
    end

    false
  end

  def perform_jump(position)
    return false unless self.board[position].nil?
    if possible_jumps.include?(position)
      capture(self.position, position)
      self.position = position
      return true
    end
  end

  def perform(move_type, position)
    return false unless self.board[position].nil?
    if possible_moves(move_type).include?(position)
      capture(self.position, position) if move_type == :jump
      self.position = position
      return true
    end

    false
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
    when :black
      print "*".black.on_white
    end
  end

  private

  def interpolate((x0, y0), (x2, y2))
    [(x0 + x2) / 2, (y0 + y2) / 2]
  end

  def check_for_enemy(position)

  end

  def capture(position)
    board[position] = nil
  end

  def possible_slides
    x, y = self.position
    reachable = diffs(:slide).map { |dx, dy| [x + dx, y + dy] }

    reachable.select { |position| on_board?(position) }
  end

  def possible_jumps
    x, y = self.position
    reachable = diffs(:jump).map { |dx, dy| [x + dx, y + dy] }

    reachable.select { |position| on_board?(position) }
  end

  def diffs(move_type)
    diffs = DELTAS[self.color].dup
    diffs.map! { |x, y| [2 * x, 2 * y] } if move_type == :jump
    diffs = diffs + diffs.map { |x, y| [x, -y]} if self.king?

    diffs
  end

  def opponent
    self.color == :red ? :black : :red
  end

  def on_board?((x, y))
    x.between?(0, 7) && y.between?(0, 7)
  end

end

