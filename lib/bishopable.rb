# frozen_string_literal: true

module Bishopable
  def can_move_like_a_bishop?(current_row, current_column, row, column, board)
    return false if @row == row || @column == column

    row_modifier = row - @row
    column_modifier = column - @column

    return false unless row_modifier.abs == column_modifier.abs

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
