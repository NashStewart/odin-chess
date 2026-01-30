# frozen_string_literal: true

require 'colorize'

class Display
  def initialize(board)
    @board = board
  end

  def print_board
    puts("\e[2J\e[f") # Clear screen
    puts('  ╔══════════════════════════╗'.colorize(:gray))
    
    (0..@board.positions.length - 1).reverse_each do |row|
      row_string = "#{row + 1} ║ ".colorize(:gray)

      @board.positions[row].each_with_index do |_, column|
        row_string = row_string += symbol(row, column).to_s
      end
      
      row_string << ' ║ '.colorize(:gray)
      puts row_string
    end

    puts('  ╚══════════════════════════╝'.colorize(:gray))
    puts('     A  B  C  D  E  F  G  H    '.colorize(:gray))
  end

  private

  def symbol(row, column)
    piece = @board.piece_at(row, column)
    symbol = piece.nil? ? '   ' : " #{piece.to_s.colorize(:color => :white, :mode => :bold)} "

    if row.even?
      symbol = symbol.on_black if column.odd?
    else
      symbol = symbol.on_black if column.even?
    end

    return symbol
  end
end
