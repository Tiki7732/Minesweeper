class Tile

    attr_accessor :val, :hidden
    def initialize(val = nil)
        @val = val
        @hidden = true
    end

    def to_s
        hidden? ? (print '*') : (print @val)
    end

    def hidden?
        @hidden
    end

end