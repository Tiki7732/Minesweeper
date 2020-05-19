require_relative 'board'
require_relative 'tile'
require_relative 'player'
class Minesweeper

    def initialize
        @board = Board.new()
        @game_over = false
    end

    def reveal(pos)
        @board.reveal_tile(pos)
        @game_over = true if @board[pos].bomb?
    end

    def reveal_fringe(pos)
        #debugger
        fringe = @board.fringe_tiles(pos)
        fringe.reject!{|tile| tile if @board[tile].bomb? || @board[tile].flagged?}
        while !fringe.empty?
            first_tile = fringe.first
            if @board[first_tile].val == "0"
                fringe.concat(@board.fringe_tiles(first_tile))
                fringe.reject!{|tile| tile if @board[tile].bomb? || @board[tile].flagged?}
                reveal(fringe.shift)
            else
                reveal(fringe.shift)
            end
            #fringe.select!{|tile| @board[tile].val == '0'}
        end
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
        @board.show_board
        p "-----"
        until @game_over
             @board.render
           
            
            pos = player.get_pos
            if @board.valid_pos?(pos)
                reveal(pos)
            else
                "That was not a valid move"
                pos = player.get_pos
            end
            reveal_fringe(pos) if @board[pos].val == "0"
        end
        p "Game over!"
        @board.show_bombs
    end

end

m = Minesweeper.new
m.run

