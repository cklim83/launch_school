=begin
In the previous exercise, you wrote a number guessing game that determines
a secret number between 1 and 100, and gives the user 7 opportunities to
guess the number.

Update your solution to accept a low and high value when you create a
GuessingGame object, and use those values to compute a secret number for
the game. You should also change the number of guesses allowed so the user
can always win if she uses a good strategy. You can compute the number of
guesses with:

Math.log2(size_of_range).to_i + 1

Examples:

game = GuessingGame.new(501, 1500)
game.play

You have 10 guesses remaining.
Enter a number between 501 and 1500: 104
Invalid guess. Enter a number between 501 and 1500: 1000
Your guess is too low.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 1250
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 1375
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 80
Invalid guess. Enter a number between 501 and 1500: 1312
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 1343
Your guess is too low.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 1359
Your guess is too high.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 1351
Your guess is too high.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 1355
That's the number!

You won!

game.play
You have 10 guesses remaining.
Enter a number between 501 and 1500: 1000
Your guess is too high.

You have 9 guesses remaining.
Enter a number between 501 and 1500: 750
Your guess is too low.

You have 8 guesses remaining.
Enter a number between 501 and 1500: 875
Your guess is too high.

You have 7 guesses remaining.
Enter a number between 501 and 1500: 812
Your guess is too low.

You have 6 guesses remaining.
Enter a number between 501 and 1500: 843
Your guess is too high.

You have 5 guesses remaining.
Enter a number between 501 and 1500: 820
Your guess is too low.

You have 4 guesses remaining.
Enter a number between 501 and 1500: 830
Your guess is too low.

You have 3 guesses remaining.
Enter a number between 501 and 1500: 835
Your guess is too low.

You have 2 guesses remaining.
Enter a number between 501 and 1500: 836
Your guess is too low.

You have 1 guesses remaining.
Enter a number between 501 and 1500: 837
Your guess is too low.

You have no more guesses. You lost!

Note that a game object should start a new game with a new number
to guess with each call to #play.
=end

class GuessingGame
  def initialize(min_value, max_value)
    @range = Range.new(min_value, max_value)
    @guesses_left = Math.log2(@range.size).to_i + 1
    @secret_number = nil
  end
  
  def play
    @secret_number = range.to_a.sample
    game_loop
  end
  
  private
  
  attr_accessor :guesses_left
  attr_reader :secret_number, :range
  
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
      print "Enter a number betwwen #{range.min} and #{range.max}: "
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
    range.cover?(guess)
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

game = GuessingGame.new(501, 1500)
game.play


=begin
Solution

class GuessingGame
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

  def initialize(low, high)
    @range = low..high
    @max_guesses = Math.log2(high - low + 1).to_i + 1
    @secret_number = nil
  end

  def play
    reset
    game_result = play_game
    display_game_end_message(game_result)
  end

  private

  def reset
    @secret_number = rand(@range)
  end

  def play_game
    result = nil
    @max_guesses.downto(1) do |remaining_guesses|
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
      print "Enter a number between #{@range.first} and #{@range.last}: "
      guess = gets.chomp.to_i
      return guess if @range.cover?(guess)
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

We've made some minor changes. First, we updated #initialize to handle
initialization of the range and the number of guesses allowed, which we
store in @range and @max_guesses, respectively. We then replaced the
RANGE and MAX_GUESSES constants in the rest of the code, and deleted
the constant declarations.
=end