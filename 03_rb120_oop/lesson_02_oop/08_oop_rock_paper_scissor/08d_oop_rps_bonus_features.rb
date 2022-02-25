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
  RULES = {
    Rock: { Scissor: 'crushes', Lizard: 'crushes' },
    Paper: { Rock: 'covers', Spock: 'disproves' },
    Scissor: { Paper: 'cuts', Lizard: 'decapitates' },
    Lizard: { Paper: 'eats', Spock: 'poisons' },
    Spock: { Scissor: 'smashes', Rock: 'vaporizes' }
  }

  ABBREV = {
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

  def self.map_move(input)
    ABBREV[input]
  end

  def self.possible_moves
    RULES.keys
  end

  def initialize(value)
    @value = value
  end

  def >(other_move)
    RULES[value].keys.include? other_move.value
  end

  def <(other_move)
    RULES[other_move.value].keys.include? value
  end

  def to_s
    value.to_s
  end
end

class Player
  def initialize
    @move_history = initialize_move_history
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

  def initialize_move_history
    Move.possible_moves.each_with_object({}) do |symbol, hsh|
      hsh[symbol] = 0
    end
  end
end

class Human < Player
  MESSAGES = YAML.load_file("08f_rpsls_messages.yml")

  attr_reader :name, :move

  def initialize
    set_name
    super
  end

  def choose
    choice = nil
    loop do
      puts MESSAGES[:player_choice]
      choice = gets.chomp.downcase
      choice = Move.map_move(choice)
      break if Move.possible_moves.include? choice
      puts MESSAGES[:invalid_choice]
    end

    self.move = Move.new(choice)
    move_history[move.value] += 1
  end

  def display_move_stats
    puts "#{name}'s Move Distribution"
    super
  end

  private

  attr_writer :move

  def set_name
    answer = nil
    loop do
      puts "Please enter your name."
      answer = gets.chomp
      break unless answer.empty?
      puts "You have not entered a name!"
    end

    @name = answer.capitalize
  end
end

class Computer < Player
  NAMES = ['RD2D', 'Deep Blue', 'Smarty', 'Matrix']

  attr_reader :name, :move

  def initialize
    set_name
    super
  end

  def choose
    self.move = Move.new(move_propensity.sample)
    move_history[move.value] += 1
  end

  def display_move_stats
    puts "#{name}'s Move Distribution"
    super
  end

  private

  attr_writer :move

  def set_name
    @name = NAMES.sample
  end

  def move_propensity
    case name
    when 'RD2D' then [:Rock]
    when 'Deep Blue' then [:Paper, :Lizard] + [:Spock] * 3
    when 'Smarty' then [:Rock, :Spock, :Paper] + [:Scissor] * 3
    when 'Matrix' then [:Rock, :Paper, :Scissor, :Lizard, :Spock]
    end
  end
end

class RPSGame
  MESSAGES = YAML.load_file("08f_rpsls_messages.yml")
  WINNING_SCORE = 5

  def initialize
    display_welcome_message
    @human = Human.new
    @computer = Computer.new
    @scoreboard = ScoreBoard.new(@human.name, @computer.name)
  end

  def play
    loop do
      game_loop
      display_winner
      break unless play_again?
      reset_scores
    end

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

  def game_loop
    loop do
      select_moves
      display_result
      update_scoreboard
      break if winner?
      sleep 3
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
    winning_verb = Move::RULES[winner_move.value][loser_move.value]

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
end

RPSGame.new.play
