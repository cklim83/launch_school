class Player
  attr_reader :player_type
  attr_accessor :move, :name
  
  def initialize(player_type = :human)
    @player_type = player_type
    @move = nil
    set_name
  end
  
  def set_name
    if human?
      answer = nil
      loop do
        puts "Please enter your name."
        answer = gets.chomp
        break unless answer.empty?
        puts "You have not entered a name!"
      end
      self.name = answer
      
    else
      self.name = ['RD2D', 'Deep Blue', 'Smarty', 'Matrix'].sample
    end
  end
  
  def choose
    if human?
      choice = nil
      loop do
        puts "Please choose rock, paper or scissor."
        choice = gets.chomp
        break if ['rock', 'paper', 'scissor'].include? choice
        puts "You have entered an invalid choice. Please try again!"
      end
      self.move = choice
    else
      self.move = ['rock', 'paper', 'scissor'].sample
    end
  end
  
  def human?
    @player_type == :human
  end
end

class RPSGame
  attr_accessor :human, :computer
  
  def initialize
    @human = Player.new
    @computer = Player.new(:computer)
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