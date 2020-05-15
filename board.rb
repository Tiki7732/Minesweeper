require_relative "tile"
require_relative 'player'
class Board

    attr_reader :grid
    def initialize(size = 9, level = 1)
        @grid = Array.new(size){Array.new(size, Tile.new())}
        populate(size*level)
    end

    def populate(level)
        level.times {@grid[rand(0...@grid.length)][rand(0...@grid.length)].val = "B"}
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

    
end

b = Board.new
b.render