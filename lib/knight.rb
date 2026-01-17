# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color = 'WHITE')
    symbol = color == 'WHITE' ? '♞' : '♙♘'
    super(row, column, color, symbol)
    @never_moved = true
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    return false unless column.between?(@column - 2, @column + 2)
    return false unless row.between?(@row - 2, @row + 2) 

    move = board[row][column]

    if row == @row - 2 || row == @row + 2
      return false unless column == @column - 1 || column == @column + 1
      return true if move.nil? || move.color != @color
    elsif column == @column - 2 || column == @column + 2
      return false unless row == @row - 1 || row == @row + 1
      return true if move.nil? || move.color != @color
    end

    return false
  end

  def update_position(row, column)
    super(row, column)
    @never_moved = false
  end
end
