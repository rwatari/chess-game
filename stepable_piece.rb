require_relative 'piece'

module Stepable

  def moves
    poss_moves = []
    move_dirs.each do |dir|
      curr_pos = get_pos(pos, dir)
      next unless self.board.in_bounds?(curr_pos)
      next if self.board[curr_pos].same_team?(self)
      poss_moves << curr_pos
    end

    poss_moves
  end
end

class King < Piece
  include Stepable
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def move_dirs
    [
      [ 1,  1],
      [ 1, -1],
      [-1,  1],
      [-1, -1],
      [ 0,  1],
      [ 0, -1],
      [ 1,  0],
      [-1,  0]
    ]
  end

  def choose_symbol
    if @color == :black
      "\u{265A}"
    else
      "\u{2654}"
    end
  end
end

class Knight < Piece
  include Stepable
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def move_dirs
    [
      [ 1,  2],
      [ 1, -2],
      [-1,  2],
      [-1, -2],
      [ 2,  1],
      [ 2, -1],
      [-2, -1],
      [-2,  1]
    ]
  end

  def choose_symbol
    if @color == :black
      "\u{265E}"
    else
      "\u{2658}"
    end
  end
end
