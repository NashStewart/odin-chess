# frozen_string_literal: true

module Rookable
  def can_move_like_a_rook?(current_row, current_column, row, column, board)
    return false if current_row != row && current_column != column

    row_modifier = row - current_row
    column_modifier = column - current_column

    (current_row..row_modifier).each do |next_row|
      (current_column..column_modifier).each do |next_column|
        next if current_row == next_row && current_column == next_column
        next if row == next_row && column == next_column

        return false unless board[next_row][next_column].nil?
      end
    end

    return true
  end
end
