# frozen_string_literal: true

module Bishopable
  module_function

  def can_move_like_a_bishop?(current_row, current_column, row, column, board)
    return false if current_row == row || current_column == column

    piece = board[current_row][current_column]
    return possible_moves(piece, board).include?([row, column])
  end

  def possible_moves(piece, board)
    possible_moves = []
    up = steps(piece.row, board.length - 1)
    down = steps(piece.row, 0)
    right = steps(piece.column, board[piece.row].length - 1)
    left = steps(piece.column, 0)

    possible_moves += diagonal_moves(piece, board, up, right)
    possible_moves += diagonal_moves(piece, board, up, left)
    possible_moves += diagonal_moves(piece, board, down, right)
    possible_moves += diagonal_moves(piece, board, down, left)

    return possible_moves
  end
  
  private

  module_function

  def steps(start, stop)
    steps = []

    if start < stop
      steps = (start..stop).to_a
    else
      steps = (stop..start).to_a.reverse
    end

    return steps
  end

  def diagonal_moves(piece, board, vertical_range, horizontal_range)
    moves = []
    vertical = vertical_range.length
    horizontal = horizontal_range.length

    stop = vertical < horizontal ? vertical - 1 : horizontal - 1

    (0..stop).each do |index|
      next_row = vertical_range[index]
      next_column = horizontal_range[index]
      next if next_row == piece.row || next_column == piece.column

      move = board[next_row][next_column]
      moves << [next_row, next_column] if move.nil? || move.color != piece.color

      break unless move.nil?
    end

    return moves
  end
end
