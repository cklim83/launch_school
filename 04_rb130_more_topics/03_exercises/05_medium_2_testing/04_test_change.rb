=begin

Test Change Method - Cash Register

Write a test for the method, CashRegister#change.

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
end


=begin
Solution

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

# Other tests omitted for brevity

class CashRegisterTest < Minitest::Test
  def test_change
    register = CashRegister.new(1000)
    transaction = Transaction.new(30)
    transaction.amount_paid = 40

    assert_equal 10, register.change(transaction)
  end
end

Discussion

For this test we set up our initial objects, one CashRegister object and
one Transaction object. We also make sure to set the amount paid. Recall,
that in the last exercise we set it up so that the amount paid and the
transaction cost were the same.

In this case, we instead pay 40 dollars for a 30 dollar item. Hopefully we
'll be getting some money back! We test the actual functionality of our
CashRegister#change method with the assertion: assert_equal 10,
register.change(transaction).

We're expecting our change method to give back 10. After running the test
it seems to do just that.
=end


=begin
TO REVIEW
- I have created a setup so that we can reused common test objects. The test
  object need to be instance variables so that they can be accessed in all test
  instance methods. The setup method is run before each test method, so modifications
  in earlier test methods will not affect the value for the later ones.
=end