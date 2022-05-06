=begin

Test Prompt For Payment Method- Transaction

Write a test that verifies that Transaction#prompt_for_payment sets the
amount_paid correctly. We've changed the transaction class a bit to make
testing this a bit easier. The Transaction#prompt_for_payment now reads as:

def prompt_for_payment(input: $stdin)
  loop do
    puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f # notice that we call gets on that parameter
    break if valid_payment? && sufficient_payment?
    puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

We've added an input keyword parameter that lets the caller provide a different
source of input. The default value for the parameter is $stdin; if we don't
provide the input parameter, Ruby will use $stdin as its value.

What is $stdin? It represents the standard input stream, which is usually the
keyboard. Specifically, $stdin is a global variable that Ruby uses to represent
the default source of input. Thus, when we write code such as str = gets.chomp,
it's equivalent to str = $stdin.gets.chomp.

If we don't need to specify $stdin, then why do we need to use it with this
method? Couldn't we just call gets.chomp.to_f on line 4 above? We could, if we
always wanted to get input from the keyboard. However, sometimes we need to
get input from elsewhere. In particular, when testing interactive programs, you
don't want to sit at the keyboard and provide the same inputs over and over. It
would be nice if we could "mock" the keyboard input - that is, send input to the
program in such a way that it can read it without changing any code. That's
where code like this comes into play. We can call prompt_for_payment with an
argument that provides the input in a way that is indistinguishable from
keyboard input.

In this exercise, we'll need to simulate -- mock -- the user input. Our tests
need to be automated, so we can't prompt the user with Kernel#gets. One way to
do that is to pass a "string stream" to the method as the input parameter. Ruby
provides a string stream class called StringIO. To use it, all you need to do
is create a StringIO object that contains all of your simulated keyboard
inputs, then pass it to prompt_for_payment. For instance:

input = StringIO.new("30\n")
transaction.prompt_for_payment(input: input)

The object assigned to input here is a StringIO object that simulates the
keyboard by acting like the user type the number 30, then pressed the Return
key (\n). Check out how this works with gets:

input = StringIO.new("30\n")
number = input.gets.chomp
puts "The number was #{number}!"   # prints "The number was 30!"

With this technique, running tests for keyboard entry is a breeze. Just sit
back and watch things run. Writing the tests is a little harder. Once you
understand how a StringIO object works, though, and you modify your code for
the additional flexibility, it's not too hard.

The key to solving this exercise lies with this technique. We'll be testing a
method defined in the Transaction class. It may be best to include this test in
a new test file related to the Transaction class.
=end


require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(18)
    exact_payment = StringIO.new('18\n')
    over_payment = StringIO.new('20\n')
    under_payment = StringIO.new('5\n')
    
    expected_output = "You owe $18.\nHow much are you paying?\n"
    assert_output(expected_output) { transaction.prompt_for_payment(input: exact_payment) }
    assert_equal(18, transaction.amount_paid)
    
    expected_output = "You owe $18.\nHow much are you paying?\n"
    assert_output(expected_output) { transaction.prompt_for_payment(input: over_payment) }
    assert_equal(20, transaction.amount_paid)
  
    # Underpayment will enter a loop, second iteration of under_payment.gets will return nil. Not able to test
    # expected_output1 = "You owe $18.\nHow much are you paying?\nThat is not the correct amount. Please make sure to pay the full cost.\n"
    # assert_output(expected_output1) { transaction.prompt_for_payment(input: under_payment)  }
    # assert_equal(5, transaction.amount_paid)
  end
end

=begin
Solution

require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30\n')
    transaction.prompt_for_payment(input: input)
    assert_equal 30, transaction.amount_paid
  end
end

Discussion

With the description above, this code isn't too difficult to understand.
The test first creates a new transaction for an item whose cost is $30.
We then create a StringIO object that simulates a keyboard entry of the
number 30 followed by a newline character. Next, we pass the StringIO
object to the prompt_for_payment method.

Since prompt_for_payment will get its input from the StringIO object, it
will act exactly like it would have were we using the keyboard directly.
In this case, it will set the amount paid to $30 and return. Finally, we
can assert that the right amount was paid.
=end


=begin
CONCEPT (VERY IMPORTANT)

- gets and $stdin.gets are equivalent. Hence we could use keyword argument with 
  $stdin as default value i.e. input: $stdin to simulate
  value = input.gets.chomp is equivalent to $stdin.gets.chomp which also gets value
  from keyboard (stdin)

- To automate testing without need for manual entry by keyboard, we could use
  StringIO.new(string) to simulate
  
  
  StringIO.new('10\n').gets.chomp will return '10'. '10\n' is simulating entering 
  '10' with enter using keyboard

- In irb, we need require 'stringio' before we can use StringIO.

- However, each StringIO object can only be gets once, subsequent gets return nil

  a = StringIO.new("hello\n")
  value = a.gets.chomp  => "hello"
  second_try = a.gets   => nil
=end