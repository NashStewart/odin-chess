# frozen_string_literal: true

require_relative 'piece'

class Knight < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color = Color::WHITE)
    symbol = color == Color::WHITE ? '♞' : '♘'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    
    return possible_moves(board).include?([row, column])
  end

  def possible_moves(board)
    possible_moves = [
      [row + 2, column + 1],
      [row + 2, column - 1],
      [row - 2, column + 1],
      [row - 2, column - 1],
      [row + 1, column + 2],
      [row - 1, column + 2],
      [row + 1, column - 2],
      [row - 1, column - 2]
    ]

    possible_moves.each_with_index do |move, index|
      if out_of_bounds?(move.first, move.last, board)
        possible_moves.delete_at(index)
      else
        piece = board[move.first][move.last]
        possible_moves.delete_at(index) unless piece.nil? || piece.color != @color
      end
    end

    return possible_moves
  end
end
