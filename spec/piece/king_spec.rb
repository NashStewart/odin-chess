# frozen_string_literal: true

require_relative '../../lib/piece/king'

describe King do
  describe '#can_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when the board is empty' do
      subject(:king) { described_class.new(1, 1, white) }

      before do
        board[1][1] = king
      end

      it 'returns true for valid positive diagonal move' do
        row = 2
        column = 2

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid negative diagonal move' do
        row = 0
        column = 0

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid positive horizontal move' do
        row = 1
        column = 2

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid negative horizontal move' do
        row = 0
        column = 1

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false for horizontal move greater than one' do
        row = 1
        column = 3

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false for diagonal move greater than one' do
        row = 3
        column = 3

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has another piece on the board' do
      subject(:king) { described_class.new(1, 1, white) }
      let(:ally_king) { described_class.new(2, 2, white) }

      before do
        board[1][1] = king
        board[2][2] = ally_king
      end

      it 'returns false when other piece at given position' do
        row = 2
        column = 2

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when opponent has piece on the board' do
      subject(:king) { described_class.new(1, 1, white) }
      let(:opponent_king) { described_class.new(2, 2, black) }

      before do
        board[1][1] = king
        board[2][2] = opponent_king
      end
      
      it 'returns true when opponent piece at given position' do
        row = 2
        column = 2

        result = king.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
    end
  end
end
