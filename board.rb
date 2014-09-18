require 'colorize'
require_relative 'piece'

class Board

  def inspect
    self.display
  end

  def initialize
    @grid = Array.new(8) { Array.new(8) }
    place_pieces
  end

  def [](position)
    x, y = position
    @grid[y][x]
  end

  def []=(position, piece)
    x, y = position
    @grid[y][x] = piece
  end

  def display
    @grid.each do |row|
      row.map do |piece|
        if piece.nil?
          print " ".white.on_light_black
        else
          piece.display
        end
      end
      print "\n"
    end

    nil
  end

  private

  def place_pieces
    # red pieces
    (0..3).each do |i|
      Piece.new(self, [i * 2, 0], :red)
      Piece.new(self, [i * 2 + 1, 1], :red)
      Piece.new(self, [i * 2, 2], :red)
    end

    # black pieces
    (0..3).each do |i|
      Piece.new(self, [i * 2 + 1, 5], :black)
      Piece.new(self, [i * 2, 6], :black)
      Piece.new(self, [i * 2 + 1, 7], :black)
    end

  end

end