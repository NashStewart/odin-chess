# frozen_string_literal: true

require_relative '../color'

class Piece
  attr_reader :symbol, :color, :row, :column

  include Comparable

  def initialize(row, column, color = Color::WHITE, symbol = '')
    @row = row
    @column = column
    @color = color
    @symbol = symbol
  end

  def can_move?(row, column, board)
    return false if @row == row && @column == column
    return false if out_of_bounds?(row, column, board)

    move = board[row][column]
    return false unless move.nil? || @color != move.color

    return true
  end

  def update_position(row, column)
    @row = row
    @column = column
  end

  def possible_moves(board)

    return []
  end

  def to_s
    @symbol
  end

  def <=>(other)
    [self.symbol, self.color] <=> [other.symbol, other.color]
  end

  private

  def out_of_bounds?(row, column, board)
    return true unless row.between?(0, board.first.length - 1)
    return true unless column.between?(0, board.length - 1)
    return false
  end
end
