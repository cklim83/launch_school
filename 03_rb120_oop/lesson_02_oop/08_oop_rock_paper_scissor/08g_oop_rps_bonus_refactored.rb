require "pry"
require 'yaml'

class ScoreBoard
  def initialize(*players)
    @board = create_hash(players)
  end

  def increment(player)
    board[player] += 1
  end

  def to_s
    str = <<~TEXT
    -------------------
    *** Score Board ***
    -------------------
    %s %d
    %s %d
    -------------------    
    TEXT

    str % format_scores
  end

  def get_score(player)
    board[player]
  end

  def reset_scores
    board.each_key do |player|
      board[player] = 0
    end
  end

  private

  attr_accessor :board

  def create_hash(players)
    players.each_with_object({}) do |player, hsh|
      hsh[player] = 0
    end
  end

  def format_scores
    name_score_pairs = board.map do |name, score|
      [name[0..14].ljust(15), score]
    end
    name_score_pairs.flatten
  end
end

class Move
  include Comparable

  MAP = {
    'r' => :Rock,
    'rock' => :Rock,
    'p' => :Paper,
    'paper' => :Paper,
    'sc' => :Scissor,
    'scissor' => :Scissor,
    'l' => :Lizard,
    'lizard' => :Lizard,
    'sp' => :Spock,
    'spock' => :Spock
  }

  attr_reader :value

  def to_s
    value.to_s
  end
end

class Rock < Move
  def initialize
    @value = :Rock
  end

  def <=>(other)
    return -1 if [Paper, Spock].include? other.class
    return 0 if other.class == Rock
    1 if [Scissor, Lizard].include? other.class
  end

  def winning_verb(other)
    case other
    when Scissor then 'crushes'
    when Lizard then 'crushes'
    end
  end
end

class Paper < Move
  def initialize
    @value = :Paper
  end

  def <=>(other)
    return -1 if [Lizard, Scissor].include? other.class
    return 0 if other.class == Paper
    1 if [Rock, Spock].include? other.class
  end

  def winning_verb(other)
    case other
    when Rock then 'covers'
    when Spock then 'disproves'
    end
  end
end

class Scissor < Move
  def initialize
    @value = :Scissor
  end

  def <=>(other)
    return -1 if [Spock, Rock].include? other.class
    return 0 if other.class == Scissor
    1 if [Lizard, Paper].include? other.class
  end

  def winning_verb(other)
    case other
    when Lizard then 'decapitates'
    when Paper then 'cuts'
    end
  end
end

class Lizard < Move
  def initialize
    @value = :Lizard
  end

  def <=>(other)
    return -1 if [Scissor, Rock].include? other.class
    return 0 if other.class == Lizard
    1 if [Paper, Spock].include? other.class
  end

  def winning_verb(other)
    case other
    when Paper then 'eats'
    when Spock then 'poisons'
    end
  end
end

class Spock < Move
  def initialize
    @value = :Spock
  end

  def <=>(other)
    return -1 if [Lizard, Paper].include? other.class
    return 0 if other.class == Spock
    1 if [Scissor, Rock].include? other.class
  end

  def winning_verb(other)
    case other
    when Scissor then 'smashes'
    when Rock then 'vaporizes'
    end
  end
end

class Player
  attr_reader :name, :move

  def initialize
    @move_history = initialize_move_history
    @move = nil
  end

  def display_move_stats
    total_count = move_history.values.sum
    move_history.each do |symbol, count|
      proportion = count.fdiv(total_count) * 100
      puts format("#{symbol}: %.1f percent", proportion)
    end
  end

  private

  attr_reader :move_history
  attr_writer :move

  def initialize_move_history
    Move::MAP.values.uniq.each_with_object({}) do |symbol, hsh|
      hsh[symbol] = 0
    end
  end
end

class Human < Player
  MESSAGES = YAML.load_file("08f_rpsls_messages.yml")

  def initialize
    set_name
    super
  end

  def choose
    choice = nil
    loop do
      puts MESSAGES[:player_choice]
      choice = gets.chomp.downcase
      choice = Move::MAP[choice]
      break unless choice.nil?
      puts MESSAGES[:invalid_choice]
    end

    self.move = create_move(choice)
    move_history[move.value] += 1
  end

  def display_move_stats
    puts "#{name}'s Move Distribution"
    super
  end

  private

  def set_name
    answer = nil
    loop do
      puts "Please enter your name."
      answer = gets.chomp.strip
      break unless answer.empty?
      puts "You have not entered a name!"
    end

    @name = answer.capitalize
  end

  def create_move(type)
    case type
    when :Rock then Rock.new
    when :Paper then Paper.new
    when :Scissor then Scissor.new
    when :Lizard then Lizard.new
    when :Spock then Spock.new
    end
  end
end

class Computer < Player
  def choose
    self.move = move_propensity.sample.new
    move_history[move.value] += 1
  end

  def display_move_stats
    puts "#{name}'s Move Distribution"
    super
  end

  private

  attr_reader :move_propensity
end

class Rocky < Computer
  def initialize
    @name = 'RD2D'
    @move_propensity = [Rock]
    super
  end
end

class Spocky < Computer
  def initialize
    @name = 'Deep Blue'
    @move_propensity = [Paper, Lizard] + [Spock] * 3
    super
  end
end

class Scissory < Computer
  def initialize
    @name = 'Smarty'
    @move_propensity = [Rock, Spock, Paper] + [Scissor] * 3
    super
  end
end

class Moody < Computer
  def initialize
    @name = 'Matrix'
    @move_propensity = [Rock, Paper, Scissor, Lizard, Spock]
    super
  end
end

class RPSGame
  MESSAGES = YAML.load_file("08f_rpsls_messages.yml")
  WINNING_SCORE = 5

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = [Rocky, Spocky, Scissory, Moody].sample.new
    display_opponent
    @scoreboard = ScoreBoard.new(@human.name, @computer.name)
  end

  def play
    loop do
      game_loop
      display_winner
      break unless play_again?
      reset_scores
      clear_screen
    end

    clear_screen
    display_move_stats
    display_goodbye_message
  end

  private

  attr_reader :human, :computer, :scoreboard

  def display_welcome_message
    clear_screen
    puts MESSAGES[:welcome]

    choice = gets.chomp.downcase
    if choice == "moves"
      puts MESSAGES[:moves]
      gets
    end

    clear_screen
  end

  def clear_screen
    system "clear"
  end

  def enter_to_continue
    puts ""
    puts "Press enter to continue ..."
    gets
  end

  def game_loop
    loop do
      select_moves
      display_result
      update_scoreboard
      break if winner?
      enter_to_continue
      clear_screen
    end
  end

  def select_moves
    puts ""
    human.choose
    computer.choose

    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_result
    human_move = human.move
    computer_move = computer.move

    if human_move > computer_move
      display_round_winner(human, computer)
    elsif human_move < computer_move
      display_round_winner(computer, human)
    else
      puts "It's a tie!"
    end
  end

  def display_round_winner(winner, loser)
    winner_move = winner.move
    loser_move = loser.move
    winning_verb = winner_move.winning_verb(loser_move)

    puts "#{winner_move} #{winning_verb} #{loser_move}"
    puts "#{winner.name} won this round!"
  end

  def update_scoreboard
    if human.move > computer.move
      scoreboard.increment(human.name)
    elsif human.move < computer.move
      scoreboard.increment(computer.name)
    end

    display_score
  end

  def display_score
    puts scoreboard
  end

  def winner?
    scoreboard.get_score(human.name) == WINNING_SCORE ||
      scoreboard.get_score(computer.name) == WINNING_SCORE
  end

  def display_winner
    if scoreboard.get_score(human.name) == WINNING_SCORE
      puts "#{human.name} is the winner!"
    else
      puts "#{computer.name} is the winner!"
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

  def reset_scores
    scoreboard.reset_scores
  end

  def display_move_stats
    puts "-----------------------"
    puts "Overall Move Statistics"
    puts "-----------------------"
    human.display_move_stats
    puts ""
    computer.display_move_stats
    puts ""
  end

  def display_goodbye_message
    puts MESSAGES[:goodbye]
  end

  def display_opponent
    puts "Your opponent for today is #{computer.name}!"
  end
end

RPSGame.new.play
