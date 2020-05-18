class Tile

    attr_accessor :val, :hidden, :flagged
    def initialize(val = nil)
        @val = val
        @hidden = true
        @flagged = false
    end

    def to_s
        hidden? ? (print ' ') : (print @val)
    end

    def hidden?
        @hidden
    end

end