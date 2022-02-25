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
      break if ['rock', 'paper', 'scissor'].include? choice
      puts "You have entered an invalid choice. Please try again!"
    end
    self.move = choice
  end
  
end

class Computer < Player
  def set_name
    self.name = ['RD2D', 'Deep Blue', 'Smarty', 'Matrix'].sample
  end
  
  def choose
    self.move = ['rock', 'paper', 'scissor'].sample
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
  
  def display_winner
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
    
    case human.move
    when 'rock'
      puts "#{human.name} won!" if computer.move == 'scissor'
      puts "#{computer.name} won!" if computer.move == 'paper'
      puts "Its a tie!" if computer.move == 'rock'
    when 'paper'
      puts "#{human.name} won!" if computer.move == 'rock'
      puts "#{computer.name} won!" if computer.move == 'scissor'
      puts "Its a tie!" if computer.move == 'paper'
    when 'scissor'
      puts "#{human.name} won!" if computer.move == 'paper'
      puts "#{computer.name} won!" if computer.move == 'rock'
      puts "Its a tie!" if computer.move == 'scissor'
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
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play