# frozen_string_literal: true

require_relative 'piece'
require_relative '../move/rookable'
require_relative '../move/bishopable'

class Queen < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color)
    symbol = color == Color::WHITE ? '♛' : '♕'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)

    (
      Rookable.can_move_like_a_rook?(@row, @column, row, column, board) ||
      Bishopable.can_move_like_a_bishop?(@row, @column, row, column, board)
    )
  end
  
  def possible_moves(board)
    Rookable.possible_moves(self, board) + Bishopable.possible_moves(self, board)
  end
end
