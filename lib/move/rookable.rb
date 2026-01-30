# frozen_string_literal: true

module Rookable
  module_function

  def can_move_like_a_rook?(current_row, current_column, row, column, board)
    return false if current_row != row && current_column != column

    piece = board[current_row][current_column]
    return possible_moves(piece, board).include?([row, column])
  end

  def possible_moves(piece, board)
    up_moves(piece, board) + 
    down_moves(piece, board) +
    right_moves(piece, board) +
    left_moves(piece, board)
  end

  private

  module_function

  def up_moves(piece, board)
    up_moves = []
    row = piece.row
    column = piece.column
    up = (row + 1..board[row].length - 1)

    up.each do |next_row|
      move = board[next_row][column]
      up_moves << [next_row, column] if move.nil? || move.color != piece.color
      break unless move.nil?
    end

    return up_moves
  end

  def down_moves(piece, board)
    down_moves = []
    row = piece.row
    column = piece.column
    down = (0..row - 1)

    down.reverse_each do |next_row|
      move = board[next_row][column]
      down_moves << [next_row, column] if move.nil? || move.color != piece.color
      break unless move.nil?
    end

    return down_moves
  end
  
  def right_moves(piece, board)
    right_moves = []
    row = piece.row
    column = piece.column
    right = (column + 1..board[row].length - 1)

    right.each do |next_column|
      move = board[row][next_column]
      right_moves << [row, next_column] if move.nil? || move.color != piece.color
      break unless move.nil?
    end

    return right_moves
  end

  def left_moves(piece, board)
    left_moves = []
    row = piece.row
    column = piece.column
    left = (0..column - 1)
    
    left.reverse_each do |next_column|
      move = board[row][next_column]
      left_moves << [row, next_column] if move.nil? || move.color != piece.color
      break unless move.nil?
    end

    return left_moves
  end
end
