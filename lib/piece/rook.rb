# frozen_string_literal: true

require_relative 'piece'
require_relative '../move/rookable'

class Rook < Piece
  attr_reader :symbol, :color, :row, :column

  include Rookable

  def initialize(row, column, color)
    symbol = color == 'WHITE' ? '♜' : '♖'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    can_move_like_a_rook?(@row, @column, row, column, board)
  end
end
