# frozen_string_literal: true

require_relative '../lib/knight'

describe Knight do
  describe '#valid_move?' do
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
        column = 6

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
      it 'returns true if move is one down and two right' do
        row = 3
        column = 2

        result = knight.can_move?(row, column, board)
        
        expect(result).to eq(true)
      end
      
    #  it 'returns false for horizontal move' do
    #    row = 1
    #    column = 2

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    #  
    #  it 'returns true if first move is two spaces forward' do
    #    row = 3
    #    column = 1

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(true)
    #  end

    #  it 'returns false for move of three spaces forward' do
    #    row = 4
    #    column = 1

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end

    #  it 'returns false for backwards movement' do
    #    row = 0
    #    column = 1

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    #  
    #  it 'returns false for diagonal move' do
    #    row = 2
    #    column = 2

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    end

    #context 'when player has other pieces on the board' do
    #  subject(:knight) { described_class.new(1, 1, white) }
    #  let(:ally_knight) { described_class.new(2, 1, white) }
    #  let(:ally_knight_two) { described_class.new(2, 2, white) }

    #  before do
    #    board[1][1] = knight
    #    board[2][1] = ally_knight
    #    board[2][2] = ally_knight_two
    #  end

    #  it 'returns false if other piece is in the way' do
    #    row = 3
    #    column = 1

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    #  
    #  it 'returns false if diagonal space contains friendly piece' do
    #    row = 2
    #    column = 2

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    #end
    #
    #context 'when opponent has piece on the board' do
    #  subject(:knight) { described_class.new(1, 4, white) }
    #  let(:opponent_knight) { described_class.new(2, 3, black) }
    #  let(:opponent_knight_two) { described_class.new(2, 4, black) }

    #  before do
    #    board[1][4] = knight
    #    board[2][3] = opponent_knight
    #    board[2][4] = opponent_knight_two
    #  end

    #  it 'returns true if diagonal space contains opponent piece' do
    #    row = 2
    #    column = 3

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(true)
    #  end
    #  
    #  it 'returns false if moving forward to space occupied by opponent' do
    #    row = 2
    #    column = 4

    #    result = knight.can_move?(row, column, board)
    #    
    #    expect(result).to eq(false)
    #  end
    #end
  end
end
