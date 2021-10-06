=begin

Problem: User play game against computer. Each choose an object randomly from
amongst Rock, Paper or Scissor.

Examples / Rules:
- Rock win Scissor and conversely Scissor lose to Rock
- Paper win Rock and conversely Rock lose to Paper
- Scissor win Paper and conversely Paper lose to Scissor
- Tie if both player and computer choose the same object

Clarifications:
- None

Data Structure
- We can store the 3 objects in an constant array since they does not change

Algorithm
1) Welcome user to Rock, Paper or Scissor Game!
2) Start main program loop
3) Start user input loop
  - Prompt user to select from amongst rock, paper or scissor
  - Exit loop if user choice is valid
  - Prompt invalid input entered. User must enter only R, P or S
4) Randomly select from R, P or S for computer
5) Determine winner based on rules above.
6) Print user and computer choice and winner.
7) Ask user if he/she wants to play again.
8) Exit loop in n/no selected
9) Print thank you!

=end
GAME_ITEMS = { r: 'Rock', p: 'Paper', s: 'Scissor' }
PLAY_AGAIN = %w(y yes n no)

def prompt(message)
  puts "=> #{message}"
end

def valid_input?(input)
  GAME_ITEMS.keys.include? input
end

def first_win?(first, second)
  (first == 'Rock' && second == 'Scissor') ||
    (first == 'Paper' && second == 'Rock') ||
    (first == 'Scissor' && second == 'Paper')
end

def display_results(user_choice, computer_choice)
  if first_win?(user_choice, computer_choice)
    prompt("You won!")
  elsif first_win?(computer_choice, user_choice)
    prompt("Computer won!")
  else
    prompt("It's a tie!")
  end
end

prompt("Welcome to Rock, Paper and Scissor Game!")

loop do
  user_choice = nil
  loop do
    prompt("What is your choice? R: Rock, P: Paper or S: Scissor?")
    user_choice = gets.chomp.strip.downcase.to_sym
    break if valid_input?(user_choice)
    prompt("Invalid input. Enter either R, P or S only. Please try again!")
  end

  computer_choice = GAME_ITEMS.keys.sample

  choice_msg = "You chose #{GAME_ITEMS[user_choice]}, "\
               "Computer chose #{GAME_ITEMS[computer_choice]}!"
  prompt(choice_msg)

  display_results(GAME_ITEMS[user_choice], GAME_ITEMS[computer_choice])

  play_again = nil
  prompt("Do you want to play again? 'Y' to continue, 'N' to quit!")
  loop do
    play_again = gets.chomp.strip.downcase

    break if PLAY_AGAIN.include? play_again
    prompt("Invalid input. Choose 'Y' to play again, 'N' to quit!")
  end

  break if play_again == 'n' || play_again == 'no'
  system "clear"
end

prompt("Thank you for playing. Goodbye!")
