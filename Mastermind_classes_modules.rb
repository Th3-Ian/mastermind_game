
class Player
  require 'colorize'
  COLORS = ["red", "green", "blue", "orange", "yellow", "purple", "white"]
  attr_accessor :player
  def initialize(player, turn, computer="Cortana", color_1=nil, color_2=nil, color_3=nil, color_4=nil)
    @player = player
    @turn = 1
    @computer = computer
    @color_1 = color_1
    @color_2 = color_2
    @color_3 = color_3
    @color_4 = color_4
  end

  def self.turn_counter()
    @turn += 1
  end

  def self.display_colors()
    puts "Select colors from 'Red', 'Green', 'Blue', 'Orange', 'Yellow', 'Purple', or 'White'"
  end

  def self.win(guess)
    if guess == @@answer
      puts "Congrats that is the correct order! Winner!"
      exit
    else
      return
    end
  end

  def self.lose(turn)
    if turn == 12
      puts "You've run out of turns! Try again!"
      exit
    else
      return
    end
  end

  def self.start()
    puts "Welcome to MASTERMIND"
    puts "The name of the game is to guess a color code with four colors in order"
    puts "you can repeat colors as much as you'd like."
    puts "Choose 'Guesser' if you want the computer to make a code for you to break."
    puts "Choose 'Creator' if you want the computer to break a code you made."
    puts "What is your name?"
    @player = Player.new(gets.chomp, 1, "Cortana")
    puts "Press 1 to be the 'Guesser' and 2 to be the 'Creator'."
    answ = gets.chomp.to_i
    if answ == 1   
      comp_code
      @turn = 1
      guess
    elsif answ == 2
      create_code
      @turn = 1
      comp_guess
    else
      puts "Please choose either 1 or 2"
      start
    end
  end

  def self.guess()
    display_colors
    get_colors
    win(@color_guess)
    turn_counter
    lose(@turn)
    p @turn
    hints("person")
  end

  def self.get_colors()
    puts "Enter your four colors here"
    cg_1 = gets.chomp.downcase.to_s
    valid_code(cg_1, "nil")
    cg_2 = gets.chomp.downcase.to_s
    valid_code(cg_2, "nil")
    cg_3 = gets.chomp.downcase.to_s
    valid_code(cg_3, "nil")
    cg_4 = gets.chomp.downcase.to_s
    valid_code(cg_4, "nil")
    @color_guess = [cg_1, cg_2, cg_3, cg_4]
  end

  def self.create_code
    puts "Please select 4 colors from 'Red', 'Green', 'Blue', 'Orange', 'Yellow', 'Purple', or 'White'"
    puts "Please select your first color:"
    @color_1 = gets.chomp.downcase
    valid_code(@color_1, "create")
    puts "Please select your second color:"
    @color_2 = gets.chomp.downcase
    valid_code(@color_2, "create")
    puts "Please select your third color:"
    @color_3 = gets.chomp.downcase
    valid_code(@color_3, "create")
    puts "Please select your fourth color:"
    @color_4 = gets.chomp.downcase
    valid_code(@color_4, "create")
    @turn = 1
    p @@answer = [@color_1, @color_2, @color_3, @color_4]
    comp_guess
  end

  def self.comp_code
    @color_1 = COLORS.sample
    @color_2 = COLORS.sample
    @color_3 = COLORS.sample
    @color_4 = COLORS.sample
    @@answer = [@color_1, @color_2, @color_3, @color_4]
    p @@answer
  end

  def self.comp_guess
    cg_1 = COLORS.sample
    cg_2 = COLORS.sample
    cg_3 = COLORS.sample
    cg_4 = COLORS.sample
    @color_guess = [cg_1, cg_2, cg_3, cg_4]
    p @color_guess
    win(@color_guess)
    turn_counter
    lose(@turn)
    p @turn
    hints("computer")
  end

  def self.valid_code(color, role)
    if COLORS.include?(color)
      return
    elsif role == "create"
      puts "Please select a valid color"
      create_code
    else
      puts "Please select a valid color"
      get_colors
    end
  end

  def self.hints(user)
    puts "Your guess is #{@color_guess}"
    puts @@answer
    @hint = []
    #gives hint for the 1st color
    if @@answer[0] == @color_guess[0]
      @hint.push("•".red)
    elsif @@answer.include?(@color_guess[0])
      @hint.push("•")
    else
      @hint.push(" ")
    end

    #2nd color hint
    if @@answer[1] == @color_guess[1]
      @hint.push("•".red)
    elsif @@answer.include?(@color_guess[1])
      @hint.push("•")
    else
      @hint.push(" ")
    end

    #3rd color hint
    if @@answer[2] == @color_guess[2]
      @hint.push("•".red)
    elsif @@answer.include?(@color_guess[2])
      @hint.push("•")
    else
      @hint.push(" ")
    end

    #4th color hint
    if @@answer[3] == @color_guess[3]
      @hint.push("•".red)
    elsif @@answer.include?(@color_guess[3])
      @hint.push("•")
    else
      @hint.push(" ")
    end 

    if user == "person"
      p @hint
      guess
    else
      p @hint
      comp_guess
    end
  end
end

Player.start