require 'colorize'
class Tile

    attr_accessor :val, :hidden, :flagged, :bomb
    def initialize(val = nil)
        @val = val
        @hidden = true
        @flagged = false
        @bomb = false
    end

    def color
        if bomb? && !flagged?
            :red
        elsif flagged? && bomb?
            :green
        else
            :blue
        end
    end

    def to_s
        @val == "0" ? (print "_") : (print @val.colorize(color))
    end

    def hidden?
        @hidden
    end

    def bomb?
        @bomb
    end

    def flagged?
        @flagged
    end

end