require_relative "tile"
require 'byebug'
class Board

    attr_reader :grid
    def initialize(size = 9, level = 1)
        @grid = Array.new(size){Array.new(size) {Tile.new}}
        populate(size*level)
    end

    def populate(amount)
        bombs =Array.new(amount, "*")
        until bombs.empty?
            x = rand(0...@grid.length)
            y = rand(0...@grid.length)
            if @grid[x][y].val.nil?
                @grid[x][y].val = bombs.pop 
                @grid[x][y].bomb = true
            end
        end

        @grid.each_with_index do |row, ind1|
            row.each_with_index do |tile, ind2|
                count = 0
                fringe_tiles([ind1,ind2]).each {|fringe_tile| count +=1 if self[fringe_tile].bomb?}
                tile.val = count.to_s if tile.val.nil?
            end
        end 
    end

    def render
        @grid.each do |row|
            print "|"
            row.each do |tile|
                if tile.hidden?
                    print ' '
                elsif tile.val == "0"
                    print '_'
                else
                    tile.to_s
                end
                print "|"
            end
            print "\n"
        end
    end

    def [](pos)
        x, y = pos
        grid[x][y]
    end

    def reveal_tile(pos)
        x, y = pos
        @grid[x][y].hidden = false
    end

    def show_bombs
        @grid.each do |row|
            print "|"
            row.each do |tile|
               print tile.val if tile.bomb?
               print " " if !tile.bomb?
                print "|"
            end
            print "\n"
        end
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
        if x < 0 || x >= @grid.length
            return false
        elsif y < 0 || y >= @grid.length
            return false            
        end 
        true
    end 

    def show_board
        @grid.each do |row|
            print "|"
            row.each do |tile|
               print tile.val
                print "|"
            end
            print "\n"
        end
    end

end

# b = Board.new(10,10)
# b.render
# print "\n"
# b.show_bombs
# b.reveal_tile([1,2])

