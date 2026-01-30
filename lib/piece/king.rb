# frozen_string_literal: true

require_relative 'piece'

class King < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color)
    symbol = color == Color::WHITE ? '♚' : '♔'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    return false unless row.between?(@row - 1, @row + 1)
    return false unless column.between?(@column - 1, @column + 1)

    return possible_moves(board).include?([row, column])
  end

  def possible_moves(board)
    possible_moves = [
      [@row + 1, @column - 1],
      [@row + 1, @column],
      [@row + 1, @column + 1],
      [@row, @column - 1],
      [@row, @column + 1],
      [@row - 1, @column - 1],
      [@row - 1, @column],
      [@row - 1, @column + 1],
    ]

    possible_moves.each_with_index do |move, index|
      row = move.first
      column = move.last
      piece = board[row][column]

      unless !out_of_bounds?(row, column, board) && (piece.nil? || piece.color != @color)
        possible_moves.delete_at(index)
      end
    end

    return possible_moves
  end
end
