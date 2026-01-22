# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/piece/pawn'
require_relative '../lib/piece/rook'
require_relative '../lib/piece/knight'
require_relative '../lib/piece/bishop'
require_relative '../lib/piece/queen'
require_relative '../lib/piece/king'

describe Game do
  let(:white) { 'WHITE' }
  let(:black) { 'BLACK' }

  describe '#move_piece' do
    context 'when board is newly setup' do
      let(:white_pawn) { Pawn.new(1, 4, white) }
      let(:black_pawn) { Pawn.new(6, 4, black) }
      let(:white_rook) { Rook.new(0, 0, white) }
      let(:black_rook) { Rook.new(7, 7, black) }
      let(:white_knight) { Knight.new(0, 1, white) }
      let(:black_knight) { Knight.new(7, 6, black) }
      let(:white_bishop) { Bishop.new(0, 2, white) }
      let(:black_bishop) { Bishop.new(7, 5, black) }
      let(:white_queen) { Queen.new(0, 3, white) }
      let(:black_queen) { Queen.new(7, 3, black) }
      let(:white_king) { King.new(0, 4, white) }
      let(:black_king) { King.new(7, 4, black) }
      subject(:game) { described_class.new() }

      fit 'moves players own piece' do
        old_row = 0
        old_column = 1
        new_row = 2
        new_column = 2

        old_position_before = game.board.piece_at(old_row, old_column)
        
        game.move_piece(white_knight, new_row, new_column)
        
        old_position_after = game.board.piece_at(old_row, old_column)
        new_position = game.board.piece_at(new_row, new_column)

        expect(old_position_before.color).to eq(white_knight.color)
        expect(old_position_before.symbol).to eq(white_knight.symbol)
        expect(old_position_after).to be_nil
        expect(new_position.color).to eq(white_knight.color)
        expect(new_position.symbol).to eq(white_knight.symbol)
      end

      it 'does not move opponents piece' do
        old_row = 6
        old_column = 4
        new_row = 5
        new_column = 4

        old_position_before = game.board.piece_at(old_row, old_column)
        
        game.move_piece(white_pawn, new_row, new_column)
        
        old_position_after = game.board.piece_at(old_row, old_column)
        new_position = game.board.piece_at(new_row, new_column)

        expect(old_position_before.color).to eq(white_pawn.color)
        expect(old_position_before.symbol).to eq(white_pawn.symbol)
        expect(old_position_after).to be_nil
        expect(new_position.color).to eq(white_pawn.color)
        expect(new_position.symbol).to eq(white_pawn.symbol)
      end
    end
  end
end
