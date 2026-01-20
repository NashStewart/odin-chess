# frozen_string_literal: true

require_relative '../../lib/piece/queen'

describe Queen do
  describe '#can_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when the board is empty' do
      subject(:queen) { described_class.new(1, 1, white) }

      before do
        board[1][1] = queen
      end

      it 'returns true for valid positive diagonal move' do
        row = 6
        column = 6

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid positive horizontal move' do
        row = 1
        column = 6

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false if move is up three and right five' do
        row = 4
        column = 6

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has another piece on the board' do
      subject(:queen) { described_class.new(1, 1, white) }
      let(:ally_queen) { described_class.new(2, 2, white) }

      before do
        board[1][1] = queen
        board[2][2] = ally_queen
      end

      it 'returns false when other piece at given position' do
        row = 2
        column = 2

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false when other piece is in the way' do
        row = 3
        column = 3

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
    
    context 'when opponent has piece on the board' do
      subject(:queen) { described_class.new(1, 1, white) }
      let(:opponent_queen) { described_class.new(2, 2, black) }

      before do
        board[1][1] = queen
        board[2][2] = opponent_queen
      end
      
      it 'returns true when opponent piece at given position' do
        row = 2
        column = 2

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false when opponent piece is in the way' do
        row = 3
        column = 3

        result = queen.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
  end
end
