class TickTacToe
    LINES = [[0,1,2], [3,4,5], [6,7,8], [0,3,6], [1,4,7], [2,5,8], [0,4,8], [2,4,6]]

    def initialize(player1, player2)
        @board = [1,2,3,4,5,6,7,8,9]
        @player1 = player1
        @player2 = player2
        gameplay
    end

    def gameplay
        player = @player1
        spaces = [1,2,3,4,5,6,7,8,9]
        round = 1

        loop do
            puts ""
            puts "Round Number: #{round}"
            print_board
            puts "#{player.name}: Your turn!"
            position = gets.chomp.to_i

            if spaces.include?(position)
                spaces.delete(position)
                @board[position-1] = player.symbol

                break if win_check(player)
                break if tie_check(spaces)

                round += 1
                player == @player1 ? player = @player2 : player = @player1
            end
        end
    end

    def win_check(player)
        LINES.each do |set|
            arr = []
            set.each do |position|
                arr << @board[position]
            end
            if arr.join =~ /#{player.symbol}{3}/
                puts ""
                puts "======================"
                puts ""
                puts "#{player.name} wins!"
                print_board
                return true
            end
        end
        return false
    end

    def tie_check(spaces)
        if spaces.empty?
            puts ""
            puts "======================"
            puts ""
            puts "It's a tie, we all lose together!"
            print_board
            return true
        end
        return false
    end

    def print_board
        puts ""
        row1 = " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        row2 = " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        row3 = " #{@board[6]} | #{@board[7]} | #{@board[8]} "
        divider ="---+---+---"
        puts row1
        puts divider
        puts row2
        puts divider
        puts row3
        puts ""  
    end
end

class Player
    attr_accessor :name, :symbol
    @@picked_symbol = ""
    @@one_player = false

    def initialize
        @name = get_name()
        @symbol = get_symbol()
    end

    def get_name
        puts @@one_player == false ? "Player 1: What's your name?" : "Player 2: What's your name?"
        @@one_player = true
        return gets.chomp
    end

    def get_symbol
        symbol_set = false
        puts "What letter would you like for your piece?"
        while !symbol_set
            puts "You cannot select #{@@picked_symbol}" if @@picked_symbol != ""
            symbol = gets.chomp.upcase
            if symbol == @@picked_symbol || !/^[a-zA-Z]{1}$/.match(symbol)
                puts "Try again!"
            else
                @@picked_symbol = symbol
                symbol_set = true
                return symbol
            end
        end
    end
end

a = Player.new
b = Player.new
game = TickTacToe.new(a, b)