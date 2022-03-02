=begin
Create an object-oriented number guessing class for numbers in
the range 1 to 100, with a limit of 7 guesses per game. The game
should play like this:

game = GuessingGame.new
game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 104
Invalid guess. Enter a number between 1 and 100: 50
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 1 and 100: 75
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 85
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 0
Invalid guess. Enter a number between 1 and 100: 80

You have 3 guesses remaining.
Enter a number between 1 and 100: 81
That's the number!

You won!

game.play

You have 7 guesses remaining.
Enter a number between 1 and 100: 50
Your guess is too high.

You have 6 guesses remaining.
Enter a number between 1 and 100: 25
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 1 and 100: 37
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 1 and 100: 31
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 1 and 100: 34
Your guess is too high.

You have 2 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 1 and 100: 32
Your guess is too low.

You have no more guesses. You lost!

Note that a game object should start a new game with a new number to guess with each call to #play.
=end

class GuessingGame
  def play
    @guesses_left = 7
    @secret_number = rand(100)
    game_loop
  end
  
  private
  
  attr_accessor :guesses_left
  attr_reader :secret_number
  
  def game_loop
    system "clear"
    while guesses_left > 0
      guess = get_guess
      break if guess == secret_number
      guess_feedback(guess)
      self.guesses_left -= 1
    end
    
    print_result
  end
  
  def get_guess
    prompt_guess_left
    guess = nil
    
    loop do
      print "Enter a number betwwen 1 and 100: "
      guess = gets.chomp.to_i
      break if valid_guess?(guess)
      print "Invalid guess. "
    end
    
    guess
  end
  
  def prompt_guess_left
    if guesses_left == 1
      puts "", "You have 1 guess remaining."
    else
      puts "", "You have #{guesses_left} guesses remaining."
    end
  end
  
  def valid_guess?(guess)
    guess.between?(1,100)
  end
  
  def guess_feedback(guess)
    if guess > secret_number
      puts "Your guess is too high."
    else
      puts "Your guess is too low."
    end
  end
  
  def print_result
    if guesses_left > 0
      puts "That's the number!\n\n"
      puts "You won!"
    else
      puts "", "You have no more guesses. You lost!"
    end
  end
end

game = GuessingGame.new
game.play


=begin
Solution

class GuessingGame
  MAX_GUESSES = 7
  RANGE = 1..100

  RESULT_OF_GUESS_MESSAGE = {
    high:  "Your number is too high.",
    low:   "Your number is too low.",
    match: "That's the number!"
  }.freeze

  WIN_OR_LOSE = {
    high:  :lose,
    low:   :lose,
    match: :win
  }.freeze

  RESULT_OF_GAME_MESSAGE = {
    win:  "You won!",
    lose: "You have no more guesses. You lost!"
  }.freeze

  def initialize
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(RANGE)
  end

  def play_game
    result = nil
    MAX_GUESSES.downto(1) do |remaining_guesses|
      display_guesses_remaining(remaining_guesses)
      result = check_guess(obtain_one_guess)
      puts RESULT_OF_GUESS_MESSAGE[result]
      break if result == :match
    end
    WIN_OR_LOSE[result]
  end

  def display_guesses_remaining(remaining)
    puts
    if remaining == 1
      puts 'You have 1 guess remaining.'
    else
      puts "You have #{remaining} guesses remaining."
    end
  end

  def obtain_one_guess
    loop do
      print "Enter a number between #{RANGE.first} and #{RANGE.last}: "
      guess = gets.chomp.to_i
      return guess if RANGE.cover?(guess)
      print "Invalid guess. "
    end
  end

  def check_guess(guess_value)
    return :match if guess_value == @secret_number
    return :low if guess_value < @secret_number
    :high
  end

  def display_game_end_message(result)
    puts "", RESULT_OF_GAME_MESSAGE[result]
  end
end

Discussion

Our class begins with some constants: the number of guesses allowed per game,
the range for the secret number, and three Hashes that we use to print
messages without a lot of logic. None of these constants are necessary, but
each helps to make our code clearer.

Most classes need an #initialize method to initialize its internal state.
That isn't necessary here since we don't need to choose a secret number until
play begins. It's good practice, though, to always initialize your instance
variables in the #initialize method, even if you don't have to. It provides
a single location where you can see all your instance variables.

The #play method handles each round of the game:

    It calls #reset to reset the game, that is, generate a new secret number.
    It calls #play_game to play a single round, and returns the result (:win
    if the player wins, :lose otherwise).
    We use the result to display the game end message with 
    #display_game_end_message.

#play_game is the meat of the game: it asks the player for each guess, but no
more than allowed. If the player guesses the number, the method returns :win.
Otherwise, it returns :lose.

The loop in #play_game calls #obtain_one_guess to get a number from the player.
This method should be familiar; you've written plenty like it so far in your
Launch School experience. The call to #cover? may be unfamiliar; #cover? is
a Range method like the familiar #include? method, but is much faster than
#include? when working with Ranges.

We also call #check_guess with the guessed number, which determines whether
it's equal to, less than, or greater than the secret number, and returns the
result as a symbol. We use that symbol in #play_game to print the appropriate
result message from RESULT_OF_GUESS_MESSAGE.

#display_guesses_remaining displays the number of guesses remaining.

Further Exploration

You will need the original exercise solution for the next exercise. If you
work on this Further Exploration, keep a copy of your original solution so
you can reuse it.

We took a straightforward approach here and implemented a single class. Do
you think it's a good idea to have a Player class? What methods and data
should be part of it? How many Player objects do you need? Should you use
inheritance, a mix-in module, or a collaborative object?

CONCEPTS
- Class implementation

TO REVIEW
- Initialize instance variables in initialize, even if not used
- Use constants for values that doesnt change
  - Easier to read
  - One spot to modify their values if required 

=end