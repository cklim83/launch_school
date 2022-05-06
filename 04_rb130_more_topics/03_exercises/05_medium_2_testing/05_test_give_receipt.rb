=begin

Test Give Receipt Method - Cash Register

Write a test for method CashRegister#give_receipt that ensures it displays
a valid receipt.


Hint:

This will be something a bit new. This method outputs something to stdout.
So, that is what you will want to test. Remember to keep the minitest docs
close by, as they should prove useful for this exercise.
=end

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def setup
    @register = CashRegister.new(1000)
    @transaction = Transaction.new(18)
    @transaction.amount_paid = 20
  end
  
  def test_accept_money
    previous_amount = @register.total_money
    @register.accept_money(@transaction)
    current_amount = @register.total_money

    assert_equal(previous_amount + 20, current_amount)
  end
  
  def test_change
    expected_change = @transaction.amount_paid - @transaction.item_cost
    assert_equal(expected_change, @register.change(@transaction))
  end
  
  def test_give_receipt
    expected = "You've paid $18.\n"
    assert_output(expected) { |_| @register.give_receipt(@transaction) }
  end
end


=begin
Solution

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test

  # Other tests omitted for brevity

  def test_give_receipt
    item_cost = 35
    register = CashRegister.new(1000)
    transaction = Transaction.new(item_cost)
    assert_output("You've paid $#{item_cost}.\n") do
      register.give_receipt(transaction)
    end
  end
end

Discussion

For this test, we'll be testing that our method outputs a
certain message. To test this, we need to use the assertion, 
assert_output. Outputting a message is also considered a side
effect, so it is something we would want to test. This is
especially true since our message should reflect a state of our
current transaction. assert_output uses a slightly different
syntax than something like assert and assert_equal. We pass in
code that will produce the "actual" output via a block. Then,
internally assert_ouput compares that output to the expected
value passed in as an argument. In this case that expected value
is: "You've paid $#{item_cost}.\n" Notice that we include a
newline character at the end there. Any little nuances related
to the implementation of our method have to be taken into account.
puts appends a newline to the message that is output. We must
include that newline character in our expected value as well when
making an assertion with assert_output.
=end


=begin
TO REVIEW
- assert_output is use to test whether output matches what is expected
- It takes the expected output as an argument and the code that produce
  the actual output as an block. Note: The block DOES not take an 
  argument (tested when block parameter is printed) unlike what the
  documentation seemed to imply (IMPORTANT)

- puts appends a '\n' at end of the output string so it is important
  to match that too.
  
  
  https://docs.ruby-lang.org/en/2.0.0/MiniTest/Assertions.html#method-i-assert_output
  assert_output(stdout = nil, stderr = nil) { || ... }

  Fails if stdout or stderr do not output the expected results. Pass in nil
  if you don't care about that streams output. Pass in “” if you require it
  to be silent. Pass in a regexp if you want to pattern match.

  NOTE: this uses capture_io, not capture_subprocess_io.
=end