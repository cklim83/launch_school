require "pry"
# require "pry-byebug"

PLAYER_SYMBOL = 'O'
COMPUTER_SYMBOL = 'X'
WINNING_COMBINATIONS = [[1, 2, 3],
                        [4, 5, 6],
                        [7, 8, 9],
                        [1, 4, 7],
                        [2, 5, 8],
                        [3, 6, 9],
                        [1, 5, 9],
                        [3, 5, 7]]

def prompt(message)
  puts "#{message}"
end

def get_board(selections)
  board = [' '] * 9
  
  selections.each do |symbol, squares|
    squares.each do |square|
      board[square-1] = symbol.to_s
    end
  end
  
  board
end

def display_board(values)
  board = <<-msg
   #{values[0]} | #{values[1]} | #{values[2]} 
   -   -   -   
   #{values[3]} | #{values[4]} | #{values[5]} 
   -   -   - 
   #{values[6]} | #{values[7]} | #{values[8]} 
  msg
  
  puts board
  prompt("")
end

def display_instruction
  prompt("=========================")
  prompt("Welcome to Tic-Tac-Toe!")
  prompt("=========================")
  prompt("Please see the square positions below")
  prompt("")
  board = (1..9).to_a
  display_board(board)
end

def choose_square(symbol, available_squares)
  choice = nil
  if symbol == PLAYER_SYMBOL
    loop do
      prompt("Choose your square: #{available_squares}")
      choice = gets.chomp.to_i
    
      break if available_squares.include?(choice)
      prompt("Invalid choice. Try again!")
    end
  else
    choice = available_squares.sample
  end
  
  choice 
end

def winner?(selection)
  WINNING_COMBINATIONS.any? do |trios|
    trios.all? do |square|
      selection.include?(square)
    end
  end
  
  # # Alternative Solution
  # combinations = selection.combination(3).to_a
  # combinations.any? { |trios| WINNING_COMBINATIONS.include?(trios) }
end

def display_winner(winner_symbol)
  if winner_symbol == PLAYER_SYMBOL
    prompt("Congratulations. You won!!!")
  elsif winner_symbol == COMPUTER_SYMBOL
    prompt("Tough luck. Computer won!!!")
  else
    prompt("Its a tie!")
  end
end

def display_choice(turn, choice)
  if turn == PLAYER_SYMBOL
    prompt("You chose: #{choice}")
  else
    prompt("Computer chose: #{choice}")
  end
end

def update!(turn, choice, available_squares, selections)
  available_squares.delete(choice)
  selections[:"#{turn}"] << choice
end

def play_again?
  play_again = nil
  loop do
    prompt("Would you like to play again? (yes or no)")
    play_again = gets.chomp.downcase
    
    break if %w(y yes no n).include?(play_again)
    prompt("Invalid input!")
  end
  
  play_again == 'y' || play_again == 'yes'
end



loop do
  symbols = [PLAYER_SYMBOL, COMPUTER_SYMBOL]
  available_squares = (1..9).to_a
  selections = {"#{PLAYER_SYMBOL}": [], "#{COMPUTER_SYMBOL}": []}
  
  display_instruction
  
  loop do
    symbol = symbols.first
    choice = choose_square(symbol, available_squares)
    display_choice(symbol, choice)
    update!(symbol, choice, available_squares, selections)
    board = get_board(selections)
    display_board(board)
    
    if winner?(selections[:"#{symbol}"])
      display_winner(symbol)
      break
    elsif available_squares.empty?
      display_winner(nil)
      break
    end
    
    sleep(1)
    symbols.rotate!
  end
  
  break unless play_again?
end

prompt("Thank you for playing. Goodbye!")


# prompt("Welcome to a Game of Tic-Tag-Toe!")
# available_squares = initialize_squares
# choice = choose_square(squares)
# squares[choice] = PLAYER_SYMBOL

# choices = initialize_values
# display_board(choices)
# choose_square
# winner?
# board_full?
# display_result
# play_again?