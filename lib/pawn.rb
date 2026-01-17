# frozen_string_literal: true

require_relative 'piece'

class Pawn < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color = 'WHITE')
    symbol = color == 'WHITE' ? '♟' : '♙'
    super(row, column, color, symbol)
    @never_moved = true
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    return false unless column.between?(@column - 1, @column + 1)
    return false unless row.between?(@row + 1, @row + 2) 

    move = board[row][column]

    if move.nil? && @column == column
      return true if row == @row + 1
      return true if row == @row + 2 && @never_moved && board[@row + 1][@column].nil?
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
