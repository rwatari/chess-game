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
      temp_row = []
      color = (row < 2 ? :black : :white)

      8.times do |col|
        if row.between?(2, 5)
          temp_row << nil
        else
          temp_row << Queen.new(color, [row, col], self)
        end
      end

      @grid << temp_row
    end
  end
end
