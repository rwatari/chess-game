require_relative 'piece'
class Board
  def initialize
    make_starting_grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def move_piece(start_pos, end_pos)
    check_pos(start_pos)
    check_move(end_pos)
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
  end

  def check_pos(pos)
    if self[pos].nil?
      raise "No piece here"
    end
  end

  def check_move(pos)

  end

  protected

  def make_starting_grid
    @grid = []
    (0...8).each do |row|
      if [0, 1, 6, 7].include?(row)
        @grid << Array.new(8) { Piece.new }
      else
        @grid << Array.new(8) { nil }
      end
    end
  end
end
