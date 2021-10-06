=begin

Problem: User play game against computer. Each choose an object randomly from
amongst Rock, Paper, Scissor, Lizard and Spock.

Examples / Rules:
- Rock win Scissor
- Rock win Lizard
- Paper win Rock
- Paper win Spock
- Scissor win Paper
- Scissor win Lizard
- Lizard win Paper
- Lizard win Spock
- Spock win Rock
- Spock win Scissor
- Tie if both player and computer choose the same object

Clarifications:
- None

Data Structure
- We can store the 5 objects in an constant hash with since they does not change

Algorithm
1) Welcome user to Rock, Paper, Scissor, Spock and Lizard Game!
2) Start main program loop
3) Initialize player and computer scores to 0
4) Start game loop
    5) Start user input loop
      - Prompt user to select from amongst rock, paper, scissor, spock or lizard
      - Exit loop if user choice is valid
      - Prompt invalid input entered. User must enter only r, p, sc, sp, l
    6) Randomly select from r, p, sc, sp or l for computer
    7) Determine round winner based on rules above and update score accordingly
    8) Print user and computer choice and winner.
    9) Print grand winner when either player gets to 3. Exit loop.
10) Ask user if he/she wants to play again.
11) Exit loop in n/no selected
12) Print thank you!

=end

# Constants
GAME_ITEMS = { r: 'Rock', p: 'Paper', sc: 'Scissor',
               l: 'Lizard', sp: 'Spock' }
RULES = {
  r: [:sc, :l],
  p: [:r, :sp],
  sc: [:p, :l],
  l: [:p, :sp],
  sp: [:r, :sc]
}
WELCOME_MESSAGE = <<-MSG
Welcome to the Universe of Rock, Paper, Scissor, Lizard and Spock!

Rules Of This Universe
  - Rock crushes both Lizard and Scissor
  - Paper covers Rock and disproves Spock
  - Scissors cuts Paper and decapitates Lizard
  - Lizard eats Paper and Posions Spock
  - Spock smashes Scissor and Vaporizes Rock

You will battle our AI enabled computer. The first player to reach 
3 points wins the game!

Press any button to continue ...
MSG
CHOICE_MESSAGE = "Choose one: Rock(R), Paper(P) or Scissor(SC), Lizard(L) "\
                 "or Spock(SP)"
PLAY_AGAIN = %w(y yes n no)

# Methods
def clear_screen
  system "clear"
end

def prompt(message)
  puts "=> #{message}"
end

def get_user_choice
  user_choice = nil

  loop do
    prompt(CHOICE_MESSAGE)
    user_choice = gets.chomp.strip.downcase.to_sym

    break if valid_input?(user_choice)
    prompt("Invalid input. Choose one of the keys in bracket.")
  end
  user_choice
end

def valid_input?(input)
  GAME_ITEMS.keys.include? input
end

def print_selection(user, computer)
  selection_msg = "You chose #{GAME_ITEMS[user]}, "\
                  "Computer chose #{GAME_ITEMS[computer]}!"
  prompt(selection_msg)
end

def get_winner(user_choice, computer_choice)
  if RULES[user_choice].include?(computer_choice)
    'user'
  elsif RULES[computer_choice].include?(user_choice)
    'computer'
  else
    'tie'
  end
end

def print_round_result(winner)
  if winner == 'user'
    prompt("You won this round!")
  elsif winner == 'computer'
    prompt("Computer won this round!")
  else
    prompt("It's a tie. Go again!")
  end
end

def print_score(user, computer)
  prompt("Your Score:  #{user}")
  prompt("Computer Score: #{computer}")
end

def print_newline
  puts ""
end

def print_winner(user_score)
  if user_score == 3
    prompt("Congrats! You are victorious ...")
  else
    prompt("Alas, you are still no match for our AI powered computer ...")
  end
end

def game_play(user_score, computer_score)
  while user_score < 3 && computer_score < 3
    user_choice = get_user_choice
    computer_choice = GAME_ITEMS.keys.sample

    print_selection(user_choice, computer_choice)

    winner = get_winner(user_choice, computer_choice)
    print_round_result(winner)

    if winner == 'user'
      user_score += 1
    elsif winner == 'computer'
      computer_score += 1
    end

    print_score(user_score, computer_score)
    print_newline
  end

  print_winner(user_score)
end

def play_again?
  user_response = nil

  prompt("Do you want to play again? 'Y' to continue, 'N' to quit!")
  loop do
    user_response = gets.chomp.strip.downcase

    break if PLAY_AGAIN.include? user_response
    prompt("Invalid input. Choose 'Y' to play again, 'N' to quit!")
  end

  user_response == 'y' || user_response == 'yes'
end

# main
clear_screen
prompt(WELCOME_MESSAGE)
_ = gets

loop do # main loop
  clear_screen
  user_score = 0
  computer_score = 0

  game_play(user_score, computer_score)

  break unless play_again?
end

prompt("Thank you for playing. Goodbye!")
