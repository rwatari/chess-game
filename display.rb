require_relative 'board'
require_relative 'cursor'
require 'colorize'
class Display
  def initialize(board)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    system("clear")
    arr = []
    8.times do |row|
      row_array = []
      8.times do |col|
        pos = [row, col]
        str = render_pos(pos)
        if @cursor.cursor_pos == pos
          str = colorize_cursor(str)
        end
        row_array << str
      end
      arr << row_array.join(" | ")
    end
    puts arr.join("\n#{'-' * 29}\n")
  end

  def colorize_cursor(str)
    if @cursor.selected
      str.colorize(:background => :light_green)
    else
      str.colorize(:background => :light_red)
    end
  end

  def render_pos(pos)
    case @board[pos]
    when nil
      " "
    else
      @board[pos].to_s
    end
  end

  def render_loop
    while true
      render
      @cursor.get_input
    end
  end


end
