# frozen_string_literal: true

class Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color = Color::WHITE, symbol = '')
    @row = row
    @column = column
    @color = color
    @symbol = symbol
  end

  def can_move?(row, column, board)
    return false if @row == row && @column == column
    return false unless row.between?(0, board.first.length - 1)
    return false unless column.between?(0, board.length - 1)

    move = board[row][column]
    return false unless move.nil? || @color != move.color

    return true
  end

  def update_position(row, column)
    @row = row
    @column = column
  end

  def to_s
    @symbol
  end
end
