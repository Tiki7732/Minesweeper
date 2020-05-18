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
        @game_over = true if @board[pos].bomb?
        # if @board[pos].val = "0"
        #     @board.fringe_tiles(pos).each do |fringe_tile| 
        #         if @board[fringe_tile].val = "0"
        #             self.reveal(fringe_tile)
        #         elsif !@board[fringe_tile].bomb? || !@board[fringe_tile.flagged]
        #             @board.reveal_tile(fringe_tile)
        #         end
        #     end
        # end
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
            if @board[pos].val = "0"
                fringe = @board.fringe_tiles(pos).select {|fringe_tile| fringe_tile if !@board[fringe_tile].bomb? || !@board[fringe_tile].flagged?}
                debugger
                fringe.each {|tile| reveal(tile)}
            end
        end
        p "Game over!"
        @board.show_bombs
    end

end

m = Minesweeper.new
m.run

