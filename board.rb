require_relative "tile"
require_relative 'player'
class Board

    def initialize(size = 9)
        @grid = Array.new(9){Array.new(9, Tile.new())}
    end
end