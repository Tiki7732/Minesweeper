require_relative 'board'
require_relative 'tile'
require_relative 'player'
require 'yaml'
require 'colorize'
class Minesweeper

    def initialize
        
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
        true if @board.bomb_count == 0 
    end

    def parse_pos(pos)
        pos = pos.split(",").map!{|int| Integer(int)}
        if @board.valid_pos?(pos)
            return pos
        else
            print "That wasn't a valid position, please try again: "
            pos = gets.chomp
            parse_pos(pos)
        end
    end

    def run()
        print "Who's playing? "
        name = gets.chomp
        player = Player.new(name)
        @board = Board.new()
       #@board.show_board

        until game_over? || won?
            system("clear")
            p "Valid commands are 'reveal', 'flag', 'save, load, or 'quit"
            @board.render    
            print "\n#{player.name} enter your move: "
            move, pos = gets.chomp.split(" ")
            case move
            when 'reveal'
                @pos = parse_pos(pos)
                reveal(@pos)
                reveal_fringe(@pos) if @board[@pos].val == "0"
            when 'flag'
                @pos = parse_pos(pos)
                @board.flag(@pos)
            when 'save'
                File.open("save.yml" , "w") {|file| file.write(@board.to_yaml)}
            when 'quit'
                @game_over = true
            when 'load'
                @board = YAML.load(File.read("save.yml"))
            else
                p "Sorry that command was not recognized"
                p "Valid commands are 'reveal', 'flag', 'save, load, or 'quit"
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

