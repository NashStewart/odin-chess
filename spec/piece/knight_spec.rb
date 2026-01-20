# frozen_string_literal: true

require_relative '../../lib/piece/knight'

describe Knight do
  describe '#can_move?' do
    let(:white) { 'WHITE' }
    let(:black) { 'BLACK' }
    let(:board) { Array.new(8) { Array.new(8, nil) } }

    context 'when the board is empty' do
      subject(:knight) { described_class.new(4, 4, white) }

      before do
        board[4][4] = knight
      end

      it 'returns true if move is two up and one right' do
        row = 6
        column = 5

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns true if move is two up and one left' do
        row = 6
        column = 3

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns true if move is two down and one left' do
        row = 2
        column = 3

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true if move is two down and one right' do
        row = 2
        column = 5

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true if move is one up and two right' do
        row = 5
        column = 6

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns true if move is one up and two left' do
        row = 5
        column = 2

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end

      it 'returns true if move is one down and two left' do
        row = 3
        column = 2

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true if move is one down and two right' do
        row = 3
        column = 6

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns false if move is one down and one right' do
        row = 3
        column = 5

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns false if move is three down and one right' do
        row = 7
        column = 5

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
    end

    context 'when player has other pieces on the board' do
      subject(:knight) { described_class.new(0, 1, white) }
      let(:ally_knight) { described_class.new(2, 2, white) }
      let(:ally_knight_two) { described_class.new(1, 2, white) }

      before do
        board[0][1] = knight
        board[2][2] = ally_knight
        board[1][2] = ally_knight_two
      end

      it 'returns false if move contains friendly piece' do
        row = 2
        column = 2

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(false)
      end
      
      it 'returns true even if friendly piece is in the way' do
        row = 1
        column = 3

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
    end
    
    context 'when opponent has piece on the board' do
      subject(:knight) { described_class.new(0, 1, white) }
      let(:opponent_knight) { described_class.new(2, 2, black) }
      let(:opponent_knight_two) { described_class.new(1, 2, black) }

      before do
        board[0][1] = knight
        board[2][2] = opponent_knight
        board[1][2] = opponent_knight_two
      end

      it 'returns true if move contains opponent piece' do
        row = 2
        column = 2

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true even if enemy piece is in the way' do
        row = 1
        column = 3

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
    end
  end
end
