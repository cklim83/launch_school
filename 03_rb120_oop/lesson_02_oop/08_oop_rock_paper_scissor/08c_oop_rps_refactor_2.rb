class Move
  VALUES = ['rock', 'paper', 'scissor']

  def initialize(value)
    @value = value
  end

  def rock?
    @value == 'rock'
  end

  def paper?
    @value == 'paper'
  end

  def scissor?
    @value == 'scissor'
  end

  def >(other_move)
    (rock? && other_move.scissor?) ||
      (paper? && other_move.rock?) ||
      (scissor? && other_move.paper?)
  end

  def <(other_move)
    (rock? && other_move.paper?) ||
      (paper? && other_move.scissor?) ||
      (scissor? && other_move.rock?)
  end

  def to_s
    @value
  end
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    answer = nil
    loop do
      puts "Please enter your name."
      answer = gets.chomp
      break unless answer.empty?
      puts "You have not entered a name!"
    end
    self.name = answer
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper or scissor."
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "You have entered an invalid choice. Please try again!"
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ['RD2D', 'Deep Blue', 'Smarty', 'Matrix'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper and Scissor game!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper and Scissor game. Good bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won!"
    elsif human.move < computer.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Invalid response. Only y or n accepted."
    end

    answer == 'y'
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
