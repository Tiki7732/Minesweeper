require_relative 'board'
require_relative 'tile'
require_relative 'player'
class Minesweeper

    def initialize
        @board = Board.new
    end

    def reveal(pos)
        @board.reveal_tile(pos)
    end

    def fringe_tiles(pos)
        finge = []
        x, y = pos
        
    end

    def valid_pos?(pos)
        x, y = pos
        if x < 0 || x >= @board.grid.length
            return false
        elsif y < 0 || y >= @board.grid.length
            return false            
        end 
        true
    end 
end

m = Minesweeper.new
p m.valid_pos?([-1, 2])