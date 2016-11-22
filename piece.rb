class Piece
  attr_reader :color, :pos, :board
  def initialize(color, pos, board)
    @color = color
    @pos = pos
    @board = board
  end

  def same_team?(other_piece)
    @color == other_piece.color
  end
end
