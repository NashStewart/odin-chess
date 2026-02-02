# frozen_string_literal: true

require_relative 'color'
require_relative 'board'
require_relative 'display'

class Game
  attr_reader :board

  include Color

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(@board)
    @current_player = Color::WHITE
  end
  
  def play
    winner = nil

    until winner
      @display.print_board
      puts("\n#{@current_player}'s turn.")
      puts('Enter a move like, "B2 C3":')

      player_move = get_player_move
      next if player_move.nil?

      piece = @board.piece_at(player_move[0], player_move[1])
      next if piece.nil?

      row = player_move[2]
      column = player_move[3]
      next unless move_piece(piece, row, column)

      end_turn
    end
  end

  def move_piece(piece, row, column)
    return false unless piece.can_move?(row, column, @board.positions)
    return false unless piece.color == @current_player

    original_row = piece.row
    original_column = piece.column
    king = @current_player == Color::WHITE ? @board.white_king : @board.black_king

    @board.move_piece(piece, row, column)
    piece.update_position(row, column)

    if check?(king)
      @board.move_piece(piece, original_row, original_column)
      piece.update_position(original_row, original_column)
      return false
    end

    return true
  end

  def check?(king)
    @board.positions.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color == king.color

        return true if piece.can_move?(king.row, king.column, @board.positions)
      end
    end

    return false
  end

  def checkmate?(king)
    @board.positions.each do |row|
      row.each do |piece|
        next if piece.nil? || piece.color != king.color

        piece.possible_moves(@board.positions).each do |move|
          return false if move_breaks_check?(king, piece, move.first, move.last)
        end
      end
    end

    return check?(king)
  end

  private

  def move_breaks_check?(king, piece, row, column)
    breaks_check = false
    original_row = piece.row
    original_column = piece.column

    return false unless @board.move_piece(piece, row, column)
    piece.update_position(row, column)

    breaks_check = !check?(king)

    @board.move_piece(piece, original_row, original_column)
    piece.update_position(original_row, original_column)

    return breaks_check
  end

  def get_player_move
    player_move = []
    input = gets.chomp.chars

    return unless input.length == 5
    return unless input[0].match?(/[A-Ha-h]/)
    return unless input[1].match?(/[1-8]/)
    return unless input[3].match?(/[A-Ha-h]/)
    return unless input[4].match?(/[1-8]/)

    letters = ('a'..'h').to_a
    player_move << input[1].to_i - 1
    player_move << letters.find_index(input[0].downcase)
    player_move << input[4].to_i - 1
    player_move << letters.find_index(input[3].downcase)
    
    player_move
  end

  def end_turn
    @current_player = @current_player == Color::WHITE ? Color::BLACK : Color::WHITE
  end
end
