require_relative 'board'
require_relative 'tile'
require_relative 'player'
class Minesweeper

    def initialize
        @board = Board.new
    end

    def reveal(pos)
        @board.reveal_tile(pos)
        @board.fringe_tiles(pos).each {|tile| @board.reveal_tile(tile)}
    end

    def render()
        @board.render
    end

    def show_bombs
        @board.show_bombs
    end
end

m = Minesweeper.new
m.render
p "----"
m.reveal([2,2])

m.render
p "++++"
m.show_bombs

