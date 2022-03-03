class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals
  CENTER_KEY = 5

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def winning_key(square_marker)
    WINNING_LINES.each do |line|
      markers = @squares.values_at(*line).collect(&:marker)
      if markers.count(square_marker) == 2 &&
         line.any? { |key| unmarked_keys.include? key }
        empty_square_index = markers.index { |marker| marker != square_marker }
        return line[empty_square_index]
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  MARKERS = { 1 => 'O', 2 => 'X' }

  attr_accessor :name, :marker
  attr_reader :score

  def initialize
    @name = nil
    @marker = nil
    reset_score
  end

  def ask_for_name(whose_name)
    player_name = nil
    loop do
      puts "Please enter #{whose_name} name?"
      player_name = gets.chomp.strip.capitalize
      break unless player_name.empty?
      puts "You have not enter a valid name. Please try again!"
    end

    player_name
  end

  def increment_score
    @score += 1
  end

  def reset_score
    @score = 0
  end
end

class Human < Player
  def select_marker
    choice = nil
    loop do
      puts "Please choose your marker:", markers_to_string
      choice = gets.chomp.to_i
      break if MARKERS.keys.include? choice
      puts "Select only #{MARKERS.keys.join(' or ')}. Please try again."
    end

    MARKERS[choice]
  end

  def select_square(unmarked_keys)
    puts "Choose a square (#{joinor(unmarked_keys)}): "

    square = nil
    loop do
      square = gets.chomp.to_i
      break if unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    square
  end

  private

  def markers_to_string
    string = ""
    MARKERS.each do |key, marker|
      string << "#{key}: #{marker}\n"
    end

    string
  end

  def joinor(keys)
    return keys[0].to_s if keys.size == 1
    keys[0...-1].join(', ') + " or #{keys[-1]}"
  end
end

class TTTGame
  WINNING_SCORE = 5

  def initialize
    @board = Board.new
    @human = Human.new
    @computer = Player.new
    @current_marker = nil
    @starting_marker = nil
  end

  def play
    clear
    display_welcome_message
    game_settings
    main_game
    display_goodbye_message
  end

  private

  attr_reader :board, :human, :computer

  def clear
    system "clear"
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def game_settings
    set_players_names
    choose_your_marker
  end

  def set_players_names
    human_name = @human.ask_for_name("your")
    @human.name = human_name

    computer_name = @computer.ask_for_name("your opponent's")
    @computer.name = computer_name
  end

  def choose_your_marker
    human_marker = @human.select_marker
    @human.marker = human_marker
    @computer.marker = left_over_marker
  end

  def left_over_marker
    Player::MARKERS.values.select { |marker| marker != @human.marker }.first
  end

  def main_game
    loop do
      set_who_goes_first
      clear
      first_to_n
      display_winner
      break unless play_again?
      reset_board_and_scores
      display_play_again_message
    end
  end

  def set_who_goes_first
    choice = who_goes_first

    @starting_marker = if choice == 'h'
                         human.marker
                       elsif choice == 'c'
                         computer.marker
                       else
                         [human.marker, computer.marker].sample
                       end

    @current_marker = @starting_marker
  end

  def who_goes_first
    choice = nil
    loop do
      puts "Please select who to start the first round."
      puts "(H)uman, (C)omputer or (R)andom?"
      choice = gets.chomp.downcase
      break if %w(h c r).include?(choice)
      puts "Invalid input. Enter either h, c or r!"
    end

    choice
  end

  def first_to_n
    loop do
      display_board
      player_move
      display_result
      update_scores
      display_scores
      break if winning_score?
      enter_to_continue
      reset_board
    end
  end

  def display_board
    puts "#{@human.name} is '#{human.marker}'."
    puts "#{@computer.name} is '#{computer.marker}'."
    puts ""
    board.draw
    puts ""
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == human.marker
  end

  def human_moves
    square = human.select_square(board.unmarked_keys)
    board[square] = human.marker
  end

  def computer_moves
    board[best_key] = computer.marker
  end

  def best_key
    offense_key = ai_offensive_key
    return offense_key if offense_key

    defense_key = ai_defensive_key
    return defense_key if defense_key

    return Board::CENTER_KEY if board.unmarked_keys.include? Board::CENTER_KEY
    board.unmarked_keys.sample
  end

  def ai_defensive_key
    board.winning_key(human.marker)
  end

  def ai_offensive_key
    board.winning_key(computer.marker)
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "#{@human.name} won this round!"
    when computer.marker
      puts "#{@computer.name} won this round!"
    else
      puts "It's a tie!"
    end
  end

  def update_scores
    case board.winning_marker
    when human.marker then human.increment_score
    when computer.marker then computer.increment_score
    end
  end

  def display_scores
    puts ""
    puts "#{@human.name}'s score: #{human.score}"
    puts "#{@computer.name}'s score: #{computer.score}"
    puts ""
  end

  def winning_score?
    !!winner_marker
  end

  def winner_marker
    return human.marker if human.score == WINNING_SCORE
    computer.marker if computer.score == WINNING_SCORE
  end

  def enter_to_continue
    puts "Press enter to continue ..."
    gets
  end

  def display_winner
    case winner_marker
    when human.marker
      puts "#{@human.name} is the overall winner!"
    when computer.marker
      puts "#{@computer.name} is the overall winner!"
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "#{@human.name}, would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end

  def reset_board_and_scores
    reset_board
    human.reset_score
    computer.reset_score
  end

  def reset_board
    board.reset
    alternate_starting_player
    @current_marker = @starting_marker
    clear
  end

  def alternate_starting_player
    @starting_marker = if @starting_marker == human.marker
                         computer.marker
                       else
                         human.marker
                       end
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end
end

game = TTTGame.new
game.play
