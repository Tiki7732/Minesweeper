class Player

    attr_reader :name
    def initialize(name)
        @name = name
    end

    def get_input
        print "#{@name} make your move: "
        pos = gets.chomp
        parse_pos(pos)
    end

    def parse_pos(pos)
        pos = pos.split(",").map!{|int| Integer(int)}
    end
end

# p = Player.new("Laurent")
# pos = p.get_pos
# p pos