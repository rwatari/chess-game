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

  def in_bounds?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  protected

  def make_starting_grid
    @grid = []
    8.times do |row|
      color = (row < 2 ? :black : :white)
      if row.between?(2, 5)
        pieces_array = Array.new(8) { NullPiece.instance }
      elsif row == 1 || row == 6
        pieces_array = (0..7).map do |col|
          Pawn.new(color, [row, col], self)
        end
      else
        pieces_array = [
          Rook.new(color, [row, 0], self),
          Knight.new(color, [row, 1], self),
          Bishop.new(color, [row, 2], self),
          Queen.new(color, [row, 3], self),
          King.new(color, [row, 4], self),
          Bishop.new(color, [row, 5], self),
          Knight.new(color, [row, 6], self),
          Rook.new(color, [row, 7], self)
        ]
      end

      @grid << pieces_array
    end
  end
end
