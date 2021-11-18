INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # horizontal
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # vertical
                [[1, 5, 9], [3, 5, 7]]              # diagonal
WINNING_SCORE = 5
CENTER_SQUARE = 5

def prompt(message)
  puts "=> #{message}"
end

def welcome_message
  system "clear"

  instructions = <<-MSG
-------------------------------------------------------------------
*******************  Welcome to Tic-Tac-Toe  **********************
-------------------------------------------------------------------
Welcome to Tic-Tac-Toe. We will be playing multiple rounds and the
first player to win 5 rounds wins the game. Before we start the
game, please familiarize yourself with the board coordinates ...

MSG

  prompt(instructions)
end

def board_position
  board = {}
  (1..9).each { |num| board[num] = num }
  board
end

def initialize_board
  board = {}
  (1..9).each { |num| board[num] = INITIAL_MARKER }
  board
end

# rubocop:disable Metrics/MethodLength, Metrics/AbcSize
def display_board(brd, clear_screen=true)
  system "clear" if clear_screen

  puts "#{PLAYER_MARKER}: Your Marker"
  puts "#{COMPUTER_MARKER}: Computer's Marker"
  puts ""
  puts "   |   |   "
  puts " #{brd[1]} | #{brd[2]} | #{brd[3]} "
  puts "   |   |   "
  puts "---+---+---"
  puts "   |   |   "
  puts " #{brd[4]} | #{brd[5]} | #{brd[6]} "
  puts "   |   |   "
  puts "---+---+---"
  puts "   |   |   "
  puts " #{brd[7]} | #{brd[8]} | #{brd[9]} "
  puts "   |   |   "
  puts ""
end
# rubocop:enable Metrics/MethodLength, Metrics/AbcSize

def who_goes_first
  choice = nil
  loop do
    prompt "We will alternate the starting player for each round"
    prompt "Please select who to start the first round" \
      "(P: player, C: Computer or R: Random)"
    choice = gets.chomp.downcase
    break if %w(p player c computer r random).include?(choice)
    prompt "Invalid input, please try again!"
  end

  return PLAYER_MARKER if choice == 'p' || choice == 'player'
  return COMPUTER_MARKER if choice == 'c' || choice == 'computer'
  [PLAYER_MARKER, COMPUTER_MARKER].sample
end

def empty_squares(brd)
  brd.keys.select { |square| brd[square] == INITIAL_MARKER }
end

def joinor(array, delimiter=', ', end_separator='or')
  case array.size
  when 0 then ""
  when 1 then array[0].to_s
  when 2 then array[0].to_s + " #{end_separator} #{array.last}"
  else
    array[0, array.size - 1].join(delimiter) + \
      "#{delimiter}#{end_separator} #{array.last}"
  end
end

def integer?(string)
  !!/^[1-9]+[0-9]*$/.match(string)
end

def player_turn(brd)
  square = nil
  available_squares = empty_squares(brd)

  loop do
    prompt "Please choose a square: (#{joinor(available_squares)})"
    square = gets.chomp
    if integer?(square)
      square = square.to_i
    else
      prompt "You have not entered an integer. Please try again"
      next
    end
    break if available_squares.include?(square)
    prompt "You have not selected an available square. Please try again!"
  end

  brd[square] = PLAYER_MARKER
end

def moves(brd, move_type, available_squares)
  lines = []

  detect_symbol = move_type == "offence" ? COMPUTER_MARKER : PLAYER_MARKER

  WINNING_LINES.each do |line|
    lines << line if brd.values_at(*line).count(detect_symbol) == 2
  end

  (lines.flatten) & available_squares
end

def smart_move(brd)
  available_squares = empty_squares(brd)

  offense_moves = moves(brd, "offence", available_squares)
  defense_moves = moves(brd, "defence", available_squares)

  return offense_moves.first if offense_moves.size > 0
  return defense_moves.first if defense_moves.size > 0
  return CENTER_SQUARE if available_squares.include?(CENTER_SQUARE)
  available_squares.sample
end

def computer_turn(brd)
  square = smart_move(brd)
  brd[square] = COMPUTER_MARKER
end

def place_piece!(brd, player)
  if player == PLAYER_MARKER
    player_turn(brd)
  else
    computer_turn(brd)
  end
end

def alternate_player(current_player)
  if current_player == PLAYER_MARKER
    COMPUTER_MARKER
  else
    PLAYER_MARKER
  end
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def round_result(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return PLAYER_MARKER
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return COMPUTER_MARKER
    end
  end

  nil # no winner
end

def someone_won?(brd)
  !!round_result(brd)
end

def display_round_result(winner)
  if winner == PLAYER_MARKER
    prompt "You won this round!!!"
  elsif winner == COMPUTER_MARKER
    prompt "Computer won this round!"
  else
    prompt "It's a tie!"
  end
end

def update_score!(score, winner)
  if score.keys.include?(winner)
    score[winner] += 1
  end
end

def display_score(score)
  puts ""
  puts "       SCORE        "
  puts "  You    Computer  "
  puts "   #{score[PLAYER_MARKER]}        #{score[COMPUTER_MARKER]}"
  puts ""
end

def display_winner(score)
  if score[PLAYER_MARKER] == WINNING_SCORE
    prompt "Congratulations, you have emerged victorious!!!"
  else
    prompt "Computer has got to #{WINNING_SCORE} first."\
           " Computer is the overall winner!"
  end
end

def play_again?
  choice = nil
  loop do
    prompt "Would you like to play again? (yes or no)"
    choice = gets.chomp.downcase
    break if %w(yes y no n).include?(choice)
    prompt "Invalid response!"
  end
  choice == 'yes' || choice == 'y'
end

welcome_message
display_board(board_position, false)
round_starter = who_goes_first

loop do
  score = { PLAYER_MARKER => 0, COMPUTER_MARKER => 0 }

  loop do
    board = initialize_board
    current_player = round_starter
    loop do
      display_board(board)
      place_piece!(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end

    display_board(board)
    result = round_result(board)
    display_round_result(result)
    update_score!(score, result)
    display_score(score)
    break if score[PLAYER_MARKER] == WINNING_SCORE || \
             score[COMPUTER_MARKER] == WINNING_SCORE
    prompt "Press enter to start the next game ..."
    _ = gets
    round_starter = alternate_player(round_starter)
  end

  display_winner(score)
  break unless play_again?
end

prompt "Thank you for playing. Goodbye!"
