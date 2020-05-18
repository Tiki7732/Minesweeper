class Tile

    attr_accessor :val, :hidden, :flagged, :bomb
    def initialize(val = nil)
        @val = val
        @hidden = true
        @flagged = false
        @bomb = false
    end

    def to_s
        print @val
    end

    def hidden?
        @hidden
    end

    def bomb?
        @bomb
    end

end