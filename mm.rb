
$code_arr = [" "," "," "," "]
$display_arr = [" "," "," "," "]
$guess_arr = [" "," "," "," "]
$color_arr = ["blank","yellow","blue","purple","red","orange","green","blank","yellow","blue","purple","red","orange","green","blank","yellow","blue","purple","red","orange","green","blank","yellow","blue","purple","red","orange","green"]
$turn = 0
$game_mode = ""
$difficulty = ""
$win = false
$game = nil
#duh
class CodePeg
    attr_accessor :color
    attr_accessor :position
    def initialize(color, position)
        @@color = color
        @@position = position
    end
end
#creates and sets display
class Display
    def set_display()
        p $display_arr
    end
end
#handles user input
class Input
    def set_game_mode()
        print("What role would you like to play?\nCodebreaker or Codemaker\n")
        $game_mode = gets.chomp.downcase
    end
    def set_difficulty()
        print("Choose your difficulty\nRegular\nHard\n")
        $difficulty = gets.chomp.downcase
    end
    def make_code()
        print("Enter your code\n")
        $code_arr.each_with_index do |val,i|
            print("Choose a color or blank\nAcceptable colors:\n
                Red, Blue, Green, Yellow, Purple, Orange, and Blank\n")
            color = gets.chomp.downcase
            print("Choose the index in [0,3]\n")
            $code_arr[i] = CodePeg.new(color,i)
        end
    end
    def guess()
        print("Make your guess\n")
        $guess_arr = ["","","",""]
        print("First color?\n")
        color1 = gets.chomp.downcase
        puts color1
        print("Second color?\n")
        color2 = gets.chomp.downcase
        puts color2
        print("Third color?\n")
        color3 = gets.chomp.downcase
        puts color3
        print("Fourth color?\n")
        color4 = gets.chomp.downcase
        puts color4
        $guess_arr[0] = CodePeg.new(color1,0)
        $guess_arr[1] = CodePeg.new(color2,1)
        $guess_arr[2] = CodePeg.new(color3,2)
        $guess_arr[3] = CodePeg.new(color4,3)
        $guess_arr.each_with_index do |val,i|
            if val.color == $code_arr[i].color && val.position == $code_arr[i].position
                $display_arr[i] = "black"
            elsif val.color == $code_arr[i].color || val.position == $code_arr[i].position
                $display_arr[i] == "white"
            end
        end
    end
end
#handles win conditions
class Rules
    def check_win_codebreaker()
        if $display_arr.eql?($code_arr)
            $win = true
            print("Congratulations, you won Mastermind\n")
        end
    end
    def check_win_codemaker()
        if $turn == 11
            print("Congratulations, you won Mastermind\n")
        end
    end
end
#handles computer actions
class Computer
    def make_code()
        color1 = $color_arr.sample
        color2 = $color_arr.sample
        color3 = $color_arr.sample
        color4 = $color_arr.sample
        $code_arr[0] = CodePeg.new(color1,0)
        $code_arr[1] = CodePeg.new(color2,1)
        $code_arr[2] = CodePeg.new(color3,2)
        $code_arr[3] = CodePeg.new(color4,3)
    end
    def comp_guess()
        if $difficulty == "regular"
            index1 = rand(3)
            index2 = rand(3)
            index3 = rand(3)
            index4 = rand(3)
            color1 = 
            color2 = $color_arr.sample
            color3 = $color_arr.sample
            color4 = $color_arr.sample
            $guess_arr[0] = CodePeg.new(color1,index1)
            $guess_arr[1] = CodePeg.new(color2,index2)
            $guess_arr[2] = CodePeg.new(color3,index3)
            $guess_arr[3] = CodePeg.new(color4,index4)
            $guess_arr.each_with_index do |val,i|
            if val.color == $code_arr[i].color && val.position == $code_arr[i].position
                $display_arr[i] = "black"
            elsif val.color == $code_arr[i].color || val.position == $code_arr[i].position
                $display_arr[i] == "white"
            end
        elsif $difficulty == "hard"
            if $turn == 0
                $guess_arr = [CodePeg.new(color_arr[0],0),CodePeg.new(color_arr[0],1),
                CodePeg.new(color_arr[1],2),CodePeg.new(color_arr[1],3)]
            elsif $win = true
                return
            else
                correct = []
                correct_ish = []
                $display_arr.each do |val|
                    if val = "black"
                        correct.push($display_arr.indexOf(val))
                    elsif val = "white"
                        correct_ish.push($display_arr.indexOf(val))
                    end
                end
                correct.each do |val|
                    if val == correct.length -2
                        $guess_arr[val] = CodePeg.new(color_arr[1 + $guess_arr[val].indexOf($guess_arr[val].color)])
                    else
                        $guess_arr[val] = CodePeg.new(color_arr[-1 + $guess_arr[val].indexOf($guess_arr[val].color)])
                    end
                correct_ish.each do |val|
                    if val == correct_ish.length -2
                        $guess_arr[val] = CodePeg.new(color_arr[1 + $guess_arr[val].indexOf($guess_arr[val].color)])
                    else
                        $guess_arr[val] = CodePeg.new(color_arr[-1 + $guess_arr[val].indexOf($guess_arr[val].color)])
                    end
                end
            end
        end
    end

end
#gives structure to other classs to run the game
class Game
    def initialize()
        d = Display.new
        i = Input.new
        r = Rules.new
        c = Computer.new
        i.set_game_mode
        if $game_mode == "codebreaker"
            d.set_display
        elsif $game_mode == "codemaker"
            i.set_difficulty
            d.set_display
        end
        while ($turn < 12 && !$win) do
            if $game_mode == "codebreaker"
                c.make_code
                i.guess
                r.check_win_codebreaker
                $turn += 1
            elsif $game_mode == "codemaker"
                i.make_code
                c.comp_guess
                r.check_win_codemaker
                $turn += 1
            end
        end
        print("GAME OVER\nPlayAgain(y/n)\n")
        input = gets.chomp
        if input == "y"
            $code_arr = [" "," "," "," "]
            $display_arr = [" "," "," "," "]
            $turn = 0
            $game_mode = ""
            $difficulty = ""
            $win = false
            $game = Game.new
        elsif input == "n"
            return
        end
    end
end
$game = Game.new