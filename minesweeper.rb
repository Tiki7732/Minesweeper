require_relative 'board'
require_relative 'tile'
require_relative 'player'
class Minesweeper

    def initialize
        @board = Board.new
        @game_over = false
    end

    def reveal(pos)
        @board.reveal_tile(pos)
        @game_over if @board[pos].bomb?
        @board.fringe_tiles(pos).each {|tile| @board.reveal_tile(tile)}
    end

    def render()
        @board.render
    end

    def show_bombs
        @board.show_bombs
    end

    def game_over?
        @game_over
    end

    def run
        player = Player.new("Laurent")
        until @game_over
             @board.render
            pos = player.get_pos
            if @board.valid_pos?(pos)
                reveal(pos)
            else
                "That was not a valid move"
                pos = player.get_pos
            end
        end
    end

end

m = Minesweeper.new
m.run

