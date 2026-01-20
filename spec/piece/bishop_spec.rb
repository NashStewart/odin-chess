# frozen_string_literal: true

require_relative '../../lib/piece/bishop'

describe Bishop do
  describe '#valid_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when the board is empty' do
      subject(:bishop) { described_class.new(1, 2, white) }

      before do
        board[1][2] = bishop
      end

      it 'returns true for valid positive diagonal move' do
        row = 4
        column = 5

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true for valid negative horizontal move' do
        row = 0
        column = 1

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false for horizontal move' do
        row = 1
        column = 3

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false if move is one up and three right' do
        row = 2
        column = 5

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has another piece on the board' do
      subject(:bishop) { described_class.new(1, 1, white) }
      let(:ally_bishop) { described_class.new(2, 2, white) }

      before do
        board[1][1] = bishop
        board[2][2] = ally_bishop
      end

      it 'returns false when other piece at given position' do
        row = 2
        column = 2

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false when other piece is in the way' do
        row = 3
        column = 3

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
    
    context 'when opponent has piece on the board' do
      subject(:bishop) { described_class.new(1, 1, white) }
      let(:opponent_bishop) { described_class.new(2, 2, black) }

      before do
        board[1][1] = bishop
        board[2][2] = opponent_bishop
      end
      
      it 'returns true when opponent piece at given position' do
        row = 2
        column = 2

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false when opponent piece is in the way' do
        row = 3
        column = 3

        result = bishop.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
  end
end
