require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def choose_symbol
    if @color == :black
      "\u{265F}"
    else
      "\u{2659}"
    end
  end
end
