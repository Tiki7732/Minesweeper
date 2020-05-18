require_relative "tile"
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
            @grid[x][y].val = bombs.pop if @grid[x][y].val.nil?
        end
    end

    def render
        @grid.each do |row|
            print "|"
            row.each do |tile|
                tile.to_s
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
               tile.val.nil? ? (print " ") : (print tile.val)
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

end

# b = Board.new(10,10)
# b.render
# print "\n"
# b.show_bombs
# b.reveal_tile([1,2])

