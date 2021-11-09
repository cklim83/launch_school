require 'pry'

INITIAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # horizontal
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # vertical
                [[1, 5, 9], [3, 5, 7]]              # diagonal

def prompt(message)
  puts "=> #{message}"
end

def welcome
  system "clear"
  prompt "Welcome to the tic-tac-toe game!"
  prompt "Please familiarize with board coordinates ..."
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
def draw_board(brd, clear_screen=true)
  system "clear" if clear_screen

  puts "#{PLAYER_MARKER}: You"
  puts "#{COMPUTER_MARKER}: Computer"
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

def empty_squares(brd)
  brd.keys.select { |square| brd[square] == INITIAL_MARKER }
end

def player_turn(brd)
  square = nil
  available_squares = empty_squares(brd)
  loop do
    prompt "Please choose a square: (#{available_squares.join(', ')})"
    square = gets.chomp.to_i
    break if available_squares.include?(square)
    prompt "Your choice is invalid. Please try again!"
  end

  brd[square] = PLAYER_MARKER
end

def computer_turn(brd)
  square = empty_squares(brd).sample
  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def winner(brd)
  WINNING_LINES.each do |line|
    # if brd[line[0]] == PLAYER_MARKER &&
    #   brd[line[1]] == PLAYER_MARKER &&
    #   brd[line[2]] == PLAYER_MARKER
    #   return PLAYER_MARKER
    # elsif brd[line[0]] == COMPUTER_MARKER &&
    #       brd[line[1]] == COMPUTER_MARKER &&
    #       brd[line[2]] == COMPUTER_MARKER
    #   return COMPUTER_MARKER
    # end
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return PLAYER_MARKER
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return COMPUTER_MARKER
    end
  end

  nil # no winner
end

def someone_won?(brd)
  !!winner(brd)
end

def display_result(winner)
  if winner == PLAYER_MARKER
    prompt "Congratulations, you won!!!"
  elsif winner == COMPUTER_MARKER
    prompt "Computer won!"
  else
    prompt "It's a tie!"
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

welcome
draw_board(board_position, false)
prompt "Press any key to start the game ..."
_ = gets

loop do
  board = initialize_board
  loop do
    draw_board(board)

    player_turn(board)
    break if someone_won?(board) || board_full?(board)

    computer_turn(board)
    break if someone_won?(board) || board_full?(board)
  end

  draw_board(board)
  result = winner(board)
  display_result(result)

  break unless play_again?
end

prompt "Thank you for playing tic-tac-toe. Goodbye!"
