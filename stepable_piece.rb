require_relative 'piece'

module Stepable

  def moves
    poss_moves = []
    move_dirs.each do |dir|
      curr_pos = update_pos(pos, dir)
      next unless self.board.in_bounds?(curr_pos)
      next if self.board[curr_pos].same_team?(self)
      poss_moves << curr_pos
    end

    poss_moves
  end

  def update_pos(position, diff)
    diff_x, diff_y = diff
    x, y = position
    [x + diff_x, y + diff_y]
  end
end
