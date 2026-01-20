# frozen_string_literal: true

require_relative '../../lib/piece/rook'

describe Rook do
  describe '#valid_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when the board is empty' do
      subject(:rook) { described_class.new(1, 1, white) }

      before do
        board[1][1] = rook
      end

      it 'returns true for valid vertical move' do
        row = 3
        column = 1

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid horizontal move' do
        row = 1
        column = 3

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false for non-existant position' do
        row = 8
        column = 1

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false for diagonal move' do
        row = 2
        column = 2

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has another piece on the board' do
      subject(:rook) { described_class.new(0, 0, white) }
      let(:ally_rook) { described_class.new(0, 5, white) }

      before do
        board[0][0] = rook
        board[0][5] = ally_rook
      end

      it 'returns true for valid horizontal move' do
        row = 0
        column = 4

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false when other piece at given position' do
        row = 0
        column = 5

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false when other piece is in the way' do
        row = 0
        column = 7

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
    
    context 'when opponent has piece on the board' do
      subject(:rook) { described_class.new(0, 0, white) }
      let(:opponent_rook) { described_class.new(0, 5, black) }

      before do
        board[0][0] = rook
        board[0][5] = opponent_rook
      end

      it 'returns true for valid horizontal move' do
        row = 0
        column = 4

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true when opponent piece at given position' do
        row = 0
        column = 5

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false when opponent piece is in the way' do
        row = 0
        column = 7

        result = rook.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
  end
end
