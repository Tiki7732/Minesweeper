class Tile

    attr_accessor :val, :hidden
    def initialize(val = nil)
        @val = val
        @hidden = true
    end

    def print
        print '*' : @val ? @hidden : !@hidden
    end
end