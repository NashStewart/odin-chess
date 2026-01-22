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
    return false unless column.between?(@column - 1, @column + 1)

    move = board[row][column]
    direction = @color == Color::WHITE ? 1 : -1

    return false unless row == @row + direction || row == @row + direction + direction

    if move.nil? && @column == column
      return true if row == @row + direction
      return true if row == @row + direction + direction && @never_moved && board[@row + direction][@column].nil?
    elsif !move.nil? && move.color != @color
      return true if (column == @column - 1 || column == @column + 1)
    end

    return false
  end

  def update_position(row, column)
    super(row, column)
    @never_moved = false
  end
end
