# frozen_string_literal: true

require_relative '../lib/board'
require_relative '../lib/piece/pawn'
require_relative '../lib/piece/rook'
require_relative '../lib/piece/knight'
require_relative '../lib/piece/bishop'
require_relative '../lib/piece/queen'
require_relative '../lib/piece/king'

describe Board do
  let(:white) { 'WHITE' }
  let(:black) { 'BLACK' }

  describe '#piece_at' do
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
      subject(:board) { described_class.new() }

      it 'returns white pawn at starting location' do
        row = 1
        column = 4

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_pawn.symbol)
        expect(piece.color).to eq(white_pawn.color)
      end

      it 'returns black pawn at starting location' do
        row = 6
        column = 4

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_pawn.symbol)
        expect(piece.color).to eq(black_pawn.color)
      end

      it 'returns white rook at starting location' do
        row = 0
        column = 0

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_rook.symbol)
        expect(piece.color).to eq(white_rook.color)
      end

      it 'returns black rook at starting location' do
        row = 7
        column = 7

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_rook.symbol)
        expect(piece.color).to eq(black_rook.color)
      end

      it 'returns white knight at starting location' do
        row = 0
        column = 1

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_knight.symbol)
        expect(piece.color).to eq(white_knight.color)
      end

      it 'returns black knight at starting location' do
        row = 7
        column = 6

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_knight.symbol)
        expect(piece.color).to eq(black_knight.color)
      end

      it 'returns white bishop at starting location' do
        row = 0
        column = 2

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_bishop.symbol)
        expect(piece.color).to eq(white_bishop.color)
      end

      it 'returns black bishop at starting location' do
        row = 7
        column = 5

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_bishop.symbol)
        expect(piece.color).to eq(black_bishop.color)
      end

      it 'returns white queen at starting location' do
        row = 0
        column = 3

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_queen.symbol)
        expect(piece.color).to eq(white_queen.color)
      end

      it 'returns black queen at starting location' do
        row = 7
        column = 3

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_queen.symbol)
        expect(piece.color).to eq(black_queen.color)
      end

      it 'returns white king at starting location' do
        row = 0
        column = 4

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(white_king.symbol)
        expect(piece.color).to eq(white_king.color)
      end

      it 'returns black king at starting location' do
        row = 7
        column = 4

        piece = board.piece_at(row, column)

        expect(piece.symbol).to eq(black_king.symbol)
        expect(piece.color).to eq(black_king.color)
      end

      it 'returns nil if location is empty' do
        row = 4
        column = 4

        piece = board.piece_at(row, column)

        expect(piece).to be_nil
      end

      it 'raises error if postion does not exist' do
        row = -1
        column = 8

        expect { board.piece_at(row, column) }.to raise_error(IndexError)
      end
    end
  end

  describe '#move_piece' do
    context 'when pieces are on board' do
      let(:white_pawn) { Pawn.new(1, 4, white) }
      let(:black_pawn) { Pawn.new(2, 3, white) }
      subject(:board) {
        described_class.new([
          Array.new(8, nil),
          [nil, nil, nil, nil, white_pawn, nil, nil, nil],
          [nil, nil, nil, black_pawn, nil, nil, nil, nil],
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
        ]) 
      }

      it 'updates position of piece on board' do
        old_row = 1
        old_column = 4
        new_row = 2
        new_column = 4

        board.move_piece(white_pawn, new_row, new_column)
        old_position = board.piece_at(old_row, old_column)
        new_position = board.piece_at(new_row, new_column)
        
        expect(old_position).to eq(nil)
        expect(new_position).to eq(white_pawn)
      end

      it 'does not update position if position does not exist' do
        old_row = 1
        old_column = 4
        new_row = 8
        new_column = 8

        board.move_piece(white_pawn, new_row, new_column)
        old_position = board.piece_at(old_row, old_column)
        
        expect(old_position).to eq(white_pawn)
      end
    end
  end
end
