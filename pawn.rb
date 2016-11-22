require_relative 'piece'

class Pawn < Piece
  def initialize(color, pos, board)
    super
    @symbol = choose_symbol
  end

  def moves
    poss_moves = []

    diag_dirs.each do |dir|
      new_pos = update_pos(pos, dir)
      other = @board[new_pos]
      next if other.is_a?(NullPiece) || other.same_team?(self)
      poss_moves << new_pos
    end

    straight_dirs.each do |dir|
      new_pos = update_pos(pos, dir)
      other = @board[new_pos]
      break unless other.is_a?(NullPiece)
      poss_moves << new_pos
    end

    poss_moves
  end

  def diag_dirs
    if @color == :black
      [[1, 1],[1, -1]]
    else
      [[-1, 1], [-1,-1]]
    end
  end

  def first_row?
    pos.first == (@color == :black ? 1 : 6)
  end

  def straight_dirs
    diff = @color == :black ? 1 : -1
    if first_row?
      [[diff, 0],[diff * 2, 0]]
    else
      [[diff, 0]]
    end
  end

  def choose_symbol
    if @color == :black
      "\u{265F}"
    else
      "\u{2659}"
    end
  end
end
