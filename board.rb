require_relative "tile"
require 'byebug'
class Board

    attr_reader :grid
    attr_accessor :bomb_count
    def initialize(size = 9, level = 1)
        @grid = Array.new(size){Array.new(size) {Tile.new}}
        @bomb_count = (size / 4 * 3) * level 
        populate(@bomb_count)
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

    def flag(pos)
        x, y = pos
        @bomb_count -= 1 if @grid[x][y].bomb?
        @grid[x][y].flagged = true
        @grid[x][y].hidden = false
        @grid[x][y].val = 'F'
    end

    def render
        print "  "
        @grid.each_index {|ind| print " " + ind.to_s}
        print "\n"
        @grid.each_with_index do |row, index_1|
            print "#{index_1} |"
            row.each do |tile|
                if tile.hidden?
                    print ' '
                else
                    tile.to_s
                end
                print "|"
            end
             print "\n"
           
           
        end
    end

    def all_tiles_revealed?
        @grid.each do |row|
            return true if row.all?{|tile| !tile.hidden?}
        end
        return false
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
        print "  "
        @grid.each_index {|ind| print " " + ind.to_s}
        print "\n"
        @grid.each_with_index do |row, index_1|
            print "#{index_1} |"
            row.each do |tile|
                tile.hidden = false if tile.bomb?
                print tile.to_s if tile.bomb?
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
         return false if !@grid[x][y].hidden?
        true
    end 

    def show_board
        print "  "
        @grid.each_index {|ind| print " " + ind.to_s}
        print "\n"
        @grid.each_with_index do |row, index_1|
            print "#{index_1} |"
            row.each do |tile|
               print tile.to_s
                print "|"
            end
            print "\n"
        end
    end

end

#  b = Board.new()
#  b.render
# p b.all_tiles_reveald?
# print "\n"
# b.show_bombs
# b.reveal_tile([1,2])

