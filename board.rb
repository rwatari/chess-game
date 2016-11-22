require_relative 'all_pieces'
require 'byebug'
class Board
  def initialize(grid = nil)
    if grid.nil?
      make_starting_grid
    else
      @grid = grid
    end
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
    start_piece = self[start_pos]
    check_start(start_piece)
    check_move(start_piece, end_pos)
    switch_pieces(start_pos, end_pos)
  end

  def switch_pieces(start_pos, end_pos)
    unless self[end_pos].is_a?(NullPiece)
      # set end pos to nullpiece
      self[end_pos] = NullPiece.instance
    end
    self[start_pos], self[end_pos] = self[end_pos], self[start_pos]
    self[end_pos].update_pos(end_pos)
  end

  def check_start(piece)
    if piece.is_a?(NullPiece)
      raise "No piece here"
    end
  end

  def check_move(piece, pos)
    raise "Invalid move" unless piece.moves.include?(pos)
  end

  def in_bounds?(pos)
    x, y = pos
    x.between?(0, 7) && y.between?(0, 7)
  end

  def in_check?(color)
    king = find_king(color)
    opponent_pieces = @grid.flatten.reject do |piece|
      piece.is_a?(NullPiece) || king.same_team?(piece)
    end

    opponent_pieces.any? do |piece|
      piece.moves.include?(king.pos)
    end
  end

  def find_king(color)
    #returns king instance of matching color
    @grid.flatten.each do |piece|
      return piece if piece.is_a?(King) && piece.color == color
    end
  end

  def checkmate?(color)
    return false unless in_check?(color)

    our_pieces = @grid.flatten.select do |piece|
      piece.color == color
    end

    our_pieces.all? { |piece| piece.valid_moves.empty? }
  end

  def dup
    dup_grid = @grid.map { |row| row.dup }

    new_board = Board.new(dup_grid)

    8.times do |row|
      8.times do |col|
        piece = new_board[[row, col]]
        if piece.is_a?(NullPiece)
          new_piece = NullPiece.instance
        else
          new_piece = piece.class.new(piece.color, [row, col], new_board)
        end

        new_board[[row,col]] = new_piece
      end
    end

    new_board
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
