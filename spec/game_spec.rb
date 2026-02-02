# frozen_string_literal: true

require_relative '../lib/game'
require_relative '../lib/board'
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

      it 'moves piece if move is valid' do
        old_row = 0
        old_column = 1
        new_row = 2
        new_column = 2

        game.move_piece(white_knight, new_row, new_column)

        old_position = game.board.piece_at(old_row, old_column)
        new_position = game.board.piece_at(new_row, new_column)

        expect(white_knight.row).to eq(new_row)
        expect(white_knight.column).to eq(new_column)
        expect(old_position).to be_nil
        expect(new_position).to eq(white_knight)
      end
      
      it 'does not move piece if move is invalid' do
        old_row = 0
        old_column = 1
        new_row = 1
        new_column = 2

        game.move_piece(white_knight, new_row, new_column)

        old_position = game.board.piece_at(old_row, old_column)
        new_position = game.board.piece_at(new_row, new_column)

        expect(white_knight.row).to eq(old_row)
        expect(white_knight.column).to eq(old_column)
        expect(old_position).to eq(white_knight)
        expect(new_position).to eq(white_pawn)
      end

      it 'does not move opponent piece' do
        old_row = 7
        old_column = 6
        new_row = 5
        new_column = 5

        game.move_piece(black_knight, new_row, new_column)

        old_position = game.board.piece_at(old_row, old_column)
        new_position = game.board.piece_at(new_row, new_column)

        expect(black_knight.row).to eq(old_row)
        expect(black_knight.column).to eq(old_column)
        expect(old_position).to eq(black_knight)
        expect(new_position).to be_nil
      end
    end
  end

  describe '#check?' do
    context 'when king is in check' do
      let(:white_king) { King.new(1, 1, white) }
      let(:black_rook) { Rook.new(1, 5, black) }
      subject(:board) {
        Board.new([
          Array.new(8, nil),
          [nil, white_king, nil, nil, nil, black_rook, nil, nil],
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
          Array.new(8, nil),
        ])
      }
      subject(:game) { described_class.new(board) }

      it 'returns true if opponent piece could move to king' do
        result = game.check?(white_king)

        expect(result).to eq(true)
      end

      it 'returns false if king moves out of check' do
        new_row = 2
        column = 1
        white_king.update_position(new_row, column)
        board.move_piece(white_king, new_row, column)

        result = game.check?(white_king)

        expect(result).to eq(false)
      end

      it 'returns false if king moves out of check' do
        new_row = 2
        column = 1
        white_king.update_position(new_row, column)
        board.move_piece(white_king, new_row, column)

        result = game.check?(white_king)

        expect(result).to eq(false)
      end
    end
  end

  describe '#checkmate?' do
    context 'when king is in checkmate' do
      let(:white_king) { King.new(0, 4, white) }
      let(:black_king) { King.new(7, 4, black) }
      let(:black_rook_one) { Rook.new(0, 0, black) }
      let(:black_rook_two) { Rook.new(1, 0, black) }
      let(:board) {
        Board.new(
          [
            [black_rook_one, nil, nil, nil, white_king, nil, nil, nil],
            [black_rook_two, nil, nil, nil, nil, nil, nil, nil],
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            [nil, nil, nil, nil, black_king, nil, nil, nil],
          ],
          white_king,
          black_king
        )
      }
      subject(:game) { described_class.new(board) }

      it 'returns true' do
        check = game.check?(white_king)
        checkmate = game.checkmate?(white_king)

        expect(check).to eq(true)
        expect(checkmate).to eq(true)
      end
    end

    context 'when other piece can block check' do
      let(:white_king) { King.new(0, 4, white) }
      let(:black_king) { King.new(7, 4, black) }
      let(:black_rook_one) { Rook.new(0, 0, black) }
      let(:black_rook_two) { Rook.new(1, 0, black) }
      let(:white_rook) { Rook.new(2, 2, white) }
      let(:board) {
        Board.new(
          [
            [black_rook_one, nil, nil, nil, white_king, nil, nil, nil],
            [black_rook_two, nil, nil, nil, nil, nil, nil, nil],
            [nil, nil, white_rook, nil, nil, nil, nil, nil],
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            [nil, nil, nil, nil, black_king, nil, nil, nil],
          ],
          white_king,
          black_king
        )
      }
      subject(:game) { described_class.new(board) }

      it 'returns false' do
        check = game.check?(white_king)
        checkmate = game.checkmate?(white_king)

        expect(check).to eq(true)
        expect(checkmate).to eq(false)
      end
    end

    context 'when king can take piece causing check' do
      let(:white_king) { King.new(0, 4, white) }
      let(:black_king) { King.new(7, 4, black) }
      let(:black_rook_one) { Rook.new(0, 3, black) }
      let(:black_rook_two) { Rook.new(1, 0, black) }
      let(:board) {
        Board.new(
          [
            [nil, nil, nil, black_rook_one, white_king, nil, nil, nil],
            [black_rook_two, nil, nil, nil, nil, nil, nil, nil],
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            Array.new(8, nil),
            [nil, nil, nil, nil, black_king, nil, nil, nil],
          ],
          white_king,
          black_king
        )
      }
      subject(:game) { described_class.new(board) }

      it 'returns false' do
        check = game.check?(white_king)
        checkmate = game.checkmate?(white_king)

        expect(check).to eq(true)
        expect(checkmate).to eq(false)
      end
    end
  end
end
