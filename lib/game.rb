# frozen_string_literal: true

require_relative 'color'
require_relative 'board'

class Game
  attr_reader :board

  include Color

  def initialize
    @board = Board.new
    @current_player = Color::WHITE
  end

  def move_piece(piece, row, column)
    return unless piece.can_move?(row, column, @board.positions)
    return unless piece.color == @current_player

    @board.move_piece(piece, row, column)
    piece.update_position(row, column)
  end
end
