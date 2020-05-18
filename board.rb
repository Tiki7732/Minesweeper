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
        puts @grid[x][y].val
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

end

# b = Board.new(10,10)
# b.render
# print "\n"
# b.show_bombs
# b.reveal_tile([1,2])

