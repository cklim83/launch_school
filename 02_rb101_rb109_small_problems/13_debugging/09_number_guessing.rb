=begin

Number Guessing Game

A friend of yours wrote a number guessing game. The first version he shows
you picks a random number between 1 and a provided maximum number and offers
you a given number of attempts to guess it.

However, when you try it, you notice that it's not working as expected. Run
the code and observe its behavior. Can you figure out what is wrong?

def valid_integer?(string)
  string.to_i.to_s == string
end

def guess_number(max_number, max_attempts)
  winning_number = (1..max_number).to_a.sample
  attempts = 0

  loop do
    attempts += 1
    break if attempts > max_attempts

    input = nil
    until valid_integer?(input)
      print 'Make a guess: '
      input = gets.chomp
    end

    guess = input.to_i

    if guess == winning_number
      puts 'Yes! You win.'
    else
      puts 'Nope. Too small.' if guess < winning_number
      puts 'Nope. Too big.'   if guess > winning_number

      # Try again:
      guess_number(max_number, max_attempts)
    end
  end
end

guess_number(10, 3)
=end

=begin
My answer:
We should not call `guess_number` if the player made a wrong
guess since this will generate a new winning number and the 
previous failed attempt will not be counted when determining if
the max attempt is exceeded. What we should do it remove line 39
and the program should work. We should also break to exit loop if
player guessed correctly.
=end


def valid_integer?(string)
  string.to_i.to_s == string
end

def guess_number(max_number, max_attempts)
  winning_number = (1..max_number).to_a.sample
  attempts = 0

  loop do
    attempts += 1
    break if attempts > max_attempts

    input = nil
    until valid_integer?(input)
      print 'Make a guess: '
      input = gets.chomp
    end

    guess = input.to_i

    if guess == winning_number
      puts 'Yes! You win.'
      break
    else
      puts 'Nope. Too small.' if guess < winning_number
      puts 'Nope. Too big.'   if guess > winning_number

      # Try again:
    end
  end
end

guess_number(10, 3)


=begin
Solution

def valid_integer?(string)
  string.to_i.to_s == string
end

def guess_number(max_number, max_attempts)
  winning_number = (1..max_number).to_a.sample
  attempts = 0

  loop do
    attempts += 1
    break if attempts > max_attempts

    input = nil
    until valid_integer?(input)
      print 'Make a guess: '
      input = gets.chomp
    end

    guess = input.to_i

    if guess == winning_number
      puts 'Yes! You win.'
      break
    else
      puts 'Nope. Too small.' if guess < winning_number
      puts 'Nope. Too big.'   if guess > winning_number

      # simply re-enter the loop for the next attempt
    end
  end
end

guess_number(10, 3)

Discussion

In order to stop looping when the user has guessed correctly, we add a break
statement to line 23.

The unexpected behavior exhibited when a user guesses wrongly is due to the
invocation of guess_number on line 28 of the original code. As seen in the
example debugging output provided, doing so determines a new winning_number
and resets attempts to 0 each time we re-enter the method.

It's not necessary to invoke guess_number from within the loop. We can rely
on our loop to continue prompting the user until they have either guessed
correctly or run out of guesses. Therefore we can simply remove the invocation
of guess_number from line 28.
=end