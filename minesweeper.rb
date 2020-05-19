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

    def won?
        true if @board.bomb_count == 0 #|| @board.all_tiles_revealed?
    end

    def parse_pos(pos)
        pos = pos.split(",").map!{|int| Integer(int)}
    end

    def get_pos
        print "\nEnter a position: "
        pos = gets.chomp
        pos = parse_pos(pos)
        if @board.valid_pos?(pos)
            return pos
        else
            p "That wasn't a valid position"
            get_pos
        end
    end

    def run
        player = Player.new("Laurent")
        @board.show_board
        p "-----"
        until game_over? || won?
            @board.render
            print "\n#{player.name} enter your move: "
            move = gets.chomp
            case move
            when 'reveal'
                @pos = get_pos
                reveal(@pos)
                reveal_fringe(@pos) if @board[@pos].val == "0"
            when 'flag'
                @pos = get_pos
                @board.flag(@pos)
            when 'quit'
                @game_over = true
            else
                p "Sorry that command was not recognized"
                p "Valid commands are 'reveal' or 'flag'"
            end
        end
        if game_over?
            p "Game over!"
            @board.show_bombs
        else
            p "You won!"
            @board.show_board
        end
    end

end

m = Minesweeper.new
m.run

