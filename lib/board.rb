# frozen_string_literal: true

require_relative 'color'

class Board
  attr_reader :positions

  include Color

  def initialize(positions = nil)
    positions.nil? ? set_board() : @positions = positions
  end

  def piece_at(row, column)
    @positions.fetch(row).fetch(column)
  end

  def move_piece(piece, row, column)
    return unless row.between?(0, @positions.first.length - 1)
    return unless column.between?(0, @positions.length - 1)

    @positions[piece.row][piece.column] = nil
    @positions[row][column] = piece
  end

  private

  def set_board
    @positions = Array.new(8) { Array.new(8, nil) }
    add_pawns(row = 1, color = Color::WHITE)
    add_pawns(row = 6, color = Color::BLACK)
    add_rooks()
    add_knights()
    add_bishops()
    add_queens()
    add_kings()
  end

  def add_pawns(row, color)
    @positions[row].each_with_index do |_, column|
      @positions[row][column] = Pawn.new(row, column, color)
    end
  end

  def add_rooks
    @positions[0][0] = Rook.new(0, 0, Color::WHITE)
    @positions[0][7] = Rook.new(0, 7, Color::WHITE)
    @positions[7][0] = Rook.new(7, 0, Color::BLACK)
    @positions[7][7] = Rook.new(7, 7, Color::BLACK)
  end

  def add_knights
    @positions[0][1] = Knight.new(0, 1, Color::WHITE)
    @positions[0][6] = Knight.new(0, 6, Color::WHITE)
    @positions[7][1] = Knight.new(7, 1, Color::BLACK)
    @positions[7][6] = Knight.new(7, 6, Color::BLACK)
  end

  def add_bishops
    @positions[0][2] = Bishop.new(0, 2, Color::WHITE)
    @positions[0][5] = Bishop.new(0, 5, Color::WHITE)
    @positions[7][2] = Bishop.new(7, 2, Color::BLACK)
    @positions[7][5] = Bishop.new(7, 5, Color::BLACK)
  end

  def add_queens
    @positions[0][3] = Queen.new(0, 3, Color::WHITE)
    @positions[7][3] = Queen.new(7, 3, Color::BLACK)
  end

  def add_kings
    @positions[0][4] = King.new(0, 4, Color::WHITE)
    @positions[7][4] = King.new(7, 4, Color::BLACK)
  end
end
