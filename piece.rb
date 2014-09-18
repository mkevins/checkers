require 'colorize'

class Piece

  attr_reader :board, :position, :color

  def inspect
    "#{self.color} piece"
  end

  def initialize(board, position, color)
    @board = board
    @color = color
    @position = position
    self.position = position
    @is_king = false
  end

  def position=(new_position)
    self.board[self.position] = nil # pick up piece
    @position = new_position # tell it where it belongs
    self.board[new_position] = self # put it there
  end

  def perform(move_type, position)
    return false unless self.board[position].nil?
    if range_positions(move_type).include?(position)
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

  def capture((x0, y0), (x2, y2)) # interpolate to get enemy piece
    enemy_position = [(x0 + x2) / 2, (y0 + y2) / 2]
    board[enemy_position] = nil
  end

  def range_positions(move_type)
    direction = {red: 1,   black: -1}[self.color]

    diffs = {
      slide: [[-1, direction], [1, direction]],
      jump: [[-2, 2 * direction], [2, 2 * direction]]
    }[move_type]

    if king?
      diffs = diffs + diffs.map { |x, y| [x, -y]}
    end
    x, y = self.position

    diffs.map { |dx, dy| [x + dx, y + dy] }.select do |x, y|
      x.between?(0, 7) && y.between?(0, 7)
    end
  end

  def opponent
    self.color == :red ? :black : :red
  end


end

