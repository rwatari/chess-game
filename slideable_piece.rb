require_relative 'piece'

module Slideable
  DIAGONALS = [
    [ 1,  1],
    [ 1, -1],
    [-1,  1],
    [-1, -1]
  ]

  STRAIGHTS = [
    [ 0,  1],
    [ 0, -1],
    [ 1,  0],
    [-1,  0]
  ]

  def moves
    poss_moves = []
    move_dirs.each do |dir|
      curr_pos = get_pos(pos, dir)
      while self.board.in_bounds?(curr_pos)
        if self.board[curr_pos].is_a?(NullPiece)
          poss_moves << curr_pos
        elsif self.board[curr_pos].same_team?(self)
          break
        else
          #if opposing piece
          poss_moves << curr_pos
          break
        end
        curr_pos = get_pos(curr_pos, dir)

      end
    end

    poss_moves
  end
end

class Queen < Piece
  include Slideable
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def move_dirs
    DIAGONALS + STRAIGHTS
  end

  def choose_symbol
    if @color == :black
      "\u{265B}"
    else
      "\u{2655}"
    end
  end
end

class Rook < Piece
  include Slideable
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def move_dirs
    STRAIGHTS
  end

  def choose_symbol
    if @color == :black
      "\u{265C}"
    else
      "\u{2656}"
    end
  end
end

class Bishop < Piece
  include Slideable
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def move_dirs
    DIAGONALS
  end

  def choose_symbol
    if @color == :black
      "\u{265D}"
    else
      "\u{2657}"
    end
  end
end