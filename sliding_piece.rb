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
      curr_pos = update_pos(pos, dir)
      while self.board.in_bounds?(curr_pos)
        if self.board[curr_pos] == nil
          poss_moves << curr_pos
        elsif self.board[curr_pos].same_team?(self)
          break
        else
          #if opposing piece
          poss_moves << curr_pos
          break
        end
        curr_pos = update_pos(curr_pos, dir)

      end
    end

    poss_moves
  end

  def update_pos(position, diff)
    diff_x, diff_y = diff
    x, y = position
    [x + diff_x, y + diff_y]
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
