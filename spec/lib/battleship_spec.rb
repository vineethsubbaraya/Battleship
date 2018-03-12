require 'spec_helper'
require 'battleship'

describe Battleship do
  context 'initialization' do
    let(:myboard) {Battleship.new}
    it "initializes to 10x10 array" do
      expect(myboard.board.size).to eq(10)
      expect(myboard.board.first.size).to eq(10)
    end
  end

  context "check for errors" do
    let(:myboard) {Battleship.new}
    before(:each) do
      for i in 6..8 do
        myboard.board[i][6] = "D"
      end
      for i in 2..6 do
        myboard.board[5][i] = "C"
      end
    end
    
    it "checks if a position is empty" do
      expect(myboard.send :is_empty?, [1,2]).to be true
      expect(myboard.send :is_empty?, [5,5]).to be false
    end

    it "checks if initial row is clear" do
      expect(myboard.send :row_clear, [2,4], 5).to be true
      expect(myboard.send :row_clear, [5,1], 2).to be false
      expect(myboard.send :row_clear, [5,9], 10).to be false
    end
    
    it "checks if initial column is clear" do
      expect(myboard.send :col_clear, [2,4], 3).to be true
      expect(myboard.send :col_clear, [4,6], 5).to be false
      expect(myboard.send :col_clear, [9,6], 10).to be false
    end

    it "return free rows" do
      expect(myboard.send :free_rows, 5).to match_array([[true,0,2],[false,2,5],[true,7,3]])
    end

    it "return free cols" do
      expect(myboard.send :free_cols,6).to match_array([[true,0,5],[false,5,4],[true,9,1]])
    end

    it "adds ship horizontailly of length 3" do
      myboard.free_rows_cols([7,5],"S",3)
      expect(myboard.board).to match_array([[".",".",".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".",".",".","."],[".",".",".",".",".",".",".",".",".","."],[".",".","C","C","C","C","C",".",".","."],[".",".",".",".",".",".","D",".",".","."],["S","S","S",".",".",".","D",".",".","."],[".",".",".",".",".",".","D",".",".","."],[".",".",".",".",".",".",".",".",".","."]])
    end


  end
end
