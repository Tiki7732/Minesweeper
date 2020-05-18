require_relative 'board'
require_relative 'tile'
require_relative 'player'
class Minesweeper

    def initialize
        @board = Board.new
    end

    def reveal(pos)
        @board.reveal_tile(pos)
        fringe_tiles(pos).each {|tile| reveal(tile)}
    end

    def fringe_tiles(pos)
        fringe = []
        x, y = pos
        fringe.push([x-1, y-1], [x-1, y], [x-1, y + 1])
        fringe.push([x, y-1], [x, y + 1])
        fringe.push([x+1, y-1], [x+1, y], [x+1, y + 1])
        fringe.delete_if{|position| position if !valid_pos?(position)}
        fringe
        
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

