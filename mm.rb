$code_arr = [" ", " ", " ", " "]
$display_arr = [" ", " ", " ", " "]
$guess_arr = [" ", " ", " ", " "]
$color_arr = ["blank", "yellow", "blue", "purple", "red", "orange", "green", "blank", "yellow", "blue", "purple", "red", "orange", "green", "blank", "yellow", "blue", "purple", "red", "orange", "green", "blank", "yellow", "blue", "purple", "red", "orange", "green"]
$turn = 0
$game_mode = ""
$difficulty = ""
$win = false
$game = ""
#duh lol
class CodePeg
  attr_accessor :color
  attr_accessor :position

  def initialize(color, position)
    @color = color
    @position = position
  end

  def ==(other)
    self.color == other.color &&
    self.position == other.position
  end
end

#creates and sets display
class Display
  def set_display()
    puts "Feedback: #{$display_arr}"
    puts "Guess: #{$guess_arr}"
  end
end

#handles user input
class Input
  def set_game_mode()
    print("What role would you like to play?\nCodebreaker or Codemaker\n")
    $game_mode = gets.chomp.downcase
    if $game_mode.eql?("codemaker")
      return
    elsif $game_mode.eql?("codebreaker")
      return
    else
      print("Invalid Game Mode")
      set_game_mode()
    end
  end

  def set_difficulty()
    print("Choose your difficulty\nRegular\nHard\n")
    $difficulty = gets.chomp.downcase
    if $difficulty.eql?("regular") || $difficulty.eql?("hard")
      return
    else
      print("Invalid Difficulty")
      set_difficulty()
    end
  end

  def make_code()
    print("Enter your code\n")
    $code_arr.each_with_index do |val, i|
      print("Choose a color or blank\nAcceptable colors:\n
                Red, Blue, Green, Yellow, Purple, Orange, and Blank\n")
      color = gets.chomp.downcase
      $code_arr[i] = CodePeg.new(color, i)
    end
  end

  def guess()
    $display_arr = [" ", " ", " ", " "]
    print("Make your guess\n")
    $guess_arr = ["", "", "", ""]
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
    $guess_arr[0] = CodePeg.new(color1, 0)
    $guess_arr[1] = CodePeg.new(color2, 1)
    $guess_arr[2] = CodePeg.new(color3, 2)
    $guess_arr[3] = CodePeg.new(color4, 3)
    $guess_arr.each_with_index do |val, i|
      if val == $code_arr[i]
        $display_arr[i] = "black"
      elsif val.color == $code_arr[0].color ||
            val.color == $code_arr[1].color ||
            val.color == $code_arr[2].color ||
            val.color == $code_arr[3].color
        $display_arr[i] = "white"
      end
    end
  end
end

#handles win conditions
class Rules
  def check_win_codebreaker()
    if $display_arr.all?("black") && $display_arr.none?(" ")
      $win = true
      print("Congratulations, you won Mastermind\n")
    end
  end

  def check_win_codemaker()
    if $display_arr.all?("black") && $display_arr.none?(" ")
      $win = true
      print("The machine has bested you this time\n")
    elsif $turn == 11
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
    $code_arr[0] = CodePeg.new(color1, 0)
    $code_arr[1] = CodePeg.new(color2, 1)
    $code_arr[2] = CodePeg.new(color3, 2)
    $code_arr[3] = CodePeg.new(color4, 3)
  end

  def comp_guess()
    $display_arr = [" ", " ", " ", " "]
    if $difficulty == "regular"
      color1 = $color_arr.sample
      color2 = $color_arr.sample
      color3 = $color_arr.sample
      color4 = $color_arr.sample
      $guess_arr[0] = CodePeg.new(color1, 0)
      $guess_arr[1] = CodePeg.new(color2, 1)
      $guess_arr[2] = CodePeg.new(color3, 2)
      $guess_arr[3] = CodePeg.new(color4, 3)
      $guess_arr.each_with_index do |val, i|
        if val == $code_arr[i]
          $display_arr[i] = "black"
        elsif val.color == $code_arr[0].color ||
              val.color == $code_arr[1].color ||
              val.color == $code_arr[2].color ||
              val.color == $code_arr[3].color
          $display_arr[i] = "white"
        end
      end
    end
    if $difficulty == "hard"
      if $turn == 0
        $guess_arr = [CodePeg.new($color_arr.sample, 0), CodePeg.new($color_arr.sample, 1),
                      CodePeg.new($color_arr.sample, 2), CodePeg.new($color_arr.sample, 3)]
        $guess_arr.each_with_index do |val, i|
          if val == $code_arr[i]
            $display_arr[i] = "black"
          elsif val.color == $code_arr[0].color ||
                val.color == $code_arr[1].color ||
                val.color == $code_arr[2].color ||
                val.color == $code_arr[3].color
            $display_arr[i] = "white"
          end
        end
      elsif $win == true
        return
      else
        $code_arr.each_with_index do |val,i|
          p val
          if !(val == $guess_arr[i])
            $guess_arr[i] = CodePeg.new($color_arr.sample,i)
          end
        end
        $guess_arr.each_with_index do |val, i|
          if val == $code_arr[i]
            $display_arr[i] = "black"
          elsif val.color == $code_arr[0].color ||
                val.color == $code_arr[1].color ||
                val.color == $code_arr[2].color ||
                val.color == $code_arr[3].color
            $display_arr[i] = "white"
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
    while ($turn < 12 && !$win)
      if $game_mode == "codebreaker"
        if $turn == 0
          c.make_code
        end
        i.guess
        d.set_display
        r.check_win_codebreaker
        $turn += 1
      elsif $game_mode == "codemaker"
        if $turn == 0
          i.make_code
        end
        c.comp_guess
        d.set_display
        r.check_win_codemaker
        $turn += 1
      end
    end
    print("GAME OVER\nPlayAgain(y/n)\n")
    input = gets.chomp
    if input == "y"
      $code_arr = [" ", " ", " ", " "]
      $display_arr = [" ", " ", " ", " "]
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
