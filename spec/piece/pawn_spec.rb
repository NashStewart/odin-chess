# frozen_string_literal: true

require_relative '../../lib/piece/pawn'

describe Pawn do
  describe '#can_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when pawn is white' do
      subject(:pawn) { described_class.new(1, 1, white) }

      before do
        board[1][1] = pawn
      end

      it 'returns true for one empty space forward' do
        row = 2
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false for horizontal move' do
        row = 1
        column = 2

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns true if first move is two spaces forward' do
        row = 3
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns false for move of three spaces forward' do
        row = 4
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end

      it 'returns false for backwards movement' do
        row = 0
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false for diagonal move' do
        row = 2
        column = 2

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when pawn is black' do
      subject(:pawn) { described_class.new(6, 1, black) }

      before do
        board[6][1] = pawn
      end

      it 'returns true for one empty space forward' do
        row = 5
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false for horizontal move' do
        row = 6
        column = 2

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns true if first move is two spaces forward' do
        row = 4
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns false for move of three spaces forward' do
        row = 3
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end

      it 'returns false for backwards movement' do
        row = 7
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false for diagonal move' do
        row = 5
        column = 2

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has other pieces on the board' do
      subject(:pawn) { described_class.new(1, 1, white) }
      let(:ally_pawn) { described_class.new(2, 1, white) }
      let(:ally_pawn_two) { described_class.new(2, 2, white) }

      before do
        board[1][1] = pawn
        board[2][1] = ally_pawn
        board[2][2] = ally_pawn_two
      end

      it 'returns false if other piece is in the way' do
        row = 3
        column = 1

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false if diagonal space contains friendly piece' do
        row = 2
        column = 2

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
    
    context 'when opponent has piece on the board' do
      subject(:pawn) { described_class.new(1, 4, white) }
      let(:opponent_pawn) { described_class.new(2, 3, black) }
      let(:opponent_pawn_two) { described_class.new(2, 4, black) }

      before do
        board[1][4] = pawn
        board[2][3] = opponent_pawn
        board[2][4] = opponent_pawn_two
      end

      it 'returns true if diagonal space contains opponent piece' do
        row = 2
        column = 3

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false if moving forward to space occupied by opponent' do
        row = 2
        column = 4

        result = pawn.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end
  end
end
