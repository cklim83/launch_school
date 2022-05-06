=begin

Alter Prompt For Payment Method - Transaction

You may have noticed something when running the test for the previous
exercise. And that is that our minitest output wasn't that clean.
We have some residual output from the Transaction#prompt_for_payment method.

Run options: --seed 52842

# Running:

You owe $30.
How much are you paying?
.

Finished in 0.001783s, 560.7402 runs/s, 560.7402 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

Transaction#prompt_for_payment has a call to Kernel#puts and that output
is showing up when we run our test. Your task for this exercise is to make
it so that we have "clean" output when running this test. We want to see
something like this:

Run options: --seed 4957

# Running:

.

Finished in 0.000919s, 1087.9984 runs/s, 1087.9984 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips


Hint:

The key to this exercise lies once again in the StringIO class.
Similar to the previous exercise, this will involve using another
mock object, but for output this time. The cool thing about
StringIO objects is that they can both provide input to Ruby and
consume output; for this problem, you need to consume the output
of the puts.

You may make changes to the Transaction#prompt_for_payment method
to fulfill the requirements of this exercise. Note that you should
not remove the calls to puts.

=end


=begin
Solution

require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal 30, transaction.amount_paid
  end
end

def prompt_for_payment(input: $stdin, output: $stdout)
  loop do
    output.puts "You owe $#{item_cost}.\nHow much are you paying?"
    @amount_paid = input.gets.chomp.to_f
    break if valid_payment? && sufficient_payment?
    output.puts 'That is not the correct amount. ' \
         'Please make sure to pay the full cost.'
  end
end

Discussion

For this exercise we'll have to work on two things. First, we'll create
a mock object to use in test_prompt_for_payment. output = StringIO.new
Unlike when we created a mock object for input we don't have to set the
String for our mock. We'll end up calling StringIO#puts on output and
that is what will set the String value for our StringIO mock object.
Second, we have to alter the Transaction#prompt_for_payment method to
accept a mock of our output. This will work in a similar way to how we
mocked the input. We add a new parameter to Transaction#prompt_for_payment
that will allow us to pass in an output mock object. 

def prompt_for_payment(input: $stdin, output: $stdout) 
Then, we use this output mock object within our method, we call 
StringIO#puts and the string passed to puts gets stored within the StringIO
object. It isn't output to the user. Doing this should allow us to clean up
our testing output that displays when running minitest.

Let's run the test again with our output mock:

Run options: --seed 45397

# Running:

.

Finished in 0.000912s, 1096.4154 runs/s, 1096.4154 assertions/s.

1 runs, 1 assertions, 0 failures, 0 errors, 0 skips

There, now all we see is output related to the test itself.
=end


=begin
CONCEPT
- StringIO#puts will divert output to StringIO object retrievable in 
  StringIO#string. Instead of using $stdout.puts, we can use StringIO.puts
  
=end

require 'minitest/autorun'
require_relative 'transaction'

class TransactionTest < Minitest::Test
  def test_prompt_for_payment
    transaction = Transaction.new(30)
    input = StringIO.new('30')
    output = StringIO.new
    transaction.prompt_for_payment(input: input, output: output)
    assert_equal 30, transaction.amount_paid
  end
end

