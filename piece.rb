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

  def update_pos(position, diff)
    diff_x, diff_y = diff
    x, y = position
    [x + diff_x, y + diff_y]
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

end
