# frozen_string_literal: true

require_relative 'piece'

class Rook < Piece
  attr_reader :symbol, :color, :row, :column

  def initialize(row, column, color)
    symbol = color == 'WHITE' ? '♜' : '♖'
    super(row, column, color, symbol)
  end

  def can_move?(row, column, board)
    return false unless super(row, column, board)
    return false if @row != row && @column != column

    row_modifier = row - @row
    column_modifier = column - @column

    (@row..row_modifier).each do |next_row|
      (@column..column_modifier).each do |next_column|
        next if @row == next_row && @column == next_column
        next if row == next_row && column == next_column

        return false unless board[next_row][next_column].nil?
      end
    end

    return true
  end
end
