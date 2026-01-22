# frozen_string_literal: true

require_relative 'piece'
require_relative '../move/rookable'
require_relative '../move/bishopable'

class King < Piece
  attr_reader :symbol, :color, :row, :column

  include Rookable
  include Bishopable

  def initialize(row, column, color)
    symbol = color == Color::WHITE ? '♚' : '♔'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    return false unless row.between?(@row - 1, @row + 1)
    return false unless column.between?(@column - 1, @column + 1)

    (
      can_move_like_a_rook?(@row, @column, row, column, board) ||
      can_move_like_a_bishop?(@row, @column, row, column, board)
    )
  end
end
