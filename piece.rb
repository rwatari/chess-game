require 'singleton'

class Piece
  attr_reader :color, :pos, :board
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def to_s
    @symbol
  end

  def same_team?(other_piece)
    @color == other_piece.color
  end

  def get_pos(position, diff)
    diff_x, diff_y = diff
    x, y = position
    [x + diff_x, y + diff_y]
  end

  def update_pos(new_pos)
    @pos = new_pos
  end
end

class NullPiece < Piece
  include Singleton

  def initialize
    @color = nil
  end

  def moves
    []
  end

  def to_s
    " "
  end

  def update_pos(pos)
  end
end
