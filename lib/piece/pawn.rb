# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color = Color::WHITE)
    symbol = color == Color::WHITE ? '♟' : '♙'
    super(row, column, color, symbol)
    @never_moved = true
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)

    return possible_moves(board).include?([row, column])
  end

  def possible_moves(board)
    possible_moves = []

    direction = @color == Color::WHITE ? 1 : -1
    
    diagonal_one = board[@row + direction][@column - 1]
    diagonal_two = board[@row + direction][@column + 1]
    forward_one = board[@row + direction][@column]
    forward_two = board[@row + direction + direction][@column]

    possible_moves << [@row + direction, @column - 1] unless diagonal_one.nil? || diagonal_one.color == @color
    possible_moves << [@row + direction, @column + 1] unless diagonal_two.nil? || diagonal_two.color == @color
    possible_moves << [@row + direction, @column] if forward_one.nil?
    possible_moves << [@row + direction + direction, @column] if forward_one.nil? && forward_two.nil?

    return possible_moves
  end

  def update_position(row, column)
    super(row, column)
    @never_moved = false
  end
end
