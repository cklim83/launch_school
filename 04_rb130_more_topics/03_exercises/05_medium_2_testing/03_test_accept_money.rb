=begin

Test Accept Money Method - Cash Register

We now have the foundation of our CashRegister test class set up. Let's
start testing! We'll start with the CashRegister#accept_money method.
Write a test for the #accept_money method.


Hint:
For this test, make sure that #accept_money properly changes the amount
of money returned by #total_money.` You'll also have to setup the
necessary objects to test that this method is working as intended.

=end
require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    @cash_register = CashRegister.new(100)
    assert_equal(100, @cash_register.total_money)
    
    @transaction = Transaction.new(10)
    @transaction.prompt_for_payment  # enter 12 paid when prompted
    assert_equal(112, @cash_register.accept_money(@transaction))
  end
end


=begin
Solution

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
  def test_accept_money
    register = CashRegister.new(1000)
    transaction = Transaction.new(20)
    transaction.amount_paid = 20

    previous_amount = register.total_money
    register.accept_money(transaction)
    current_amount = register.total_money

    assert_equal previous_amount + 20, current_amount
  end
end

Discussion

When you first consider this test, it may seem really simple to
write. Yet, there is quite a bit of groundwork to lay here. First,
we need to create some objects to test the #accept_money method.
#accept_money is a method from class CashRegister, so we'll need
an instance of that class. We also need an instance of class
Transaction. The method #accept_money takes a Transaction object
as an argument.

Once we have our objects, we then set the amount_paid via the
attr_accessor in the Transaction class. This is the value we'll
be checking. If our method does work as intended, then when we
process a transaction, the amount in register should increase
exactly by the amount paid.

We test this value by setting variables that represent the money
in the register before and after a transaction takes place. Finally,
we implement the approach/algorithm for this exercise with our
assertion: assert_equal previous_amount + 20, current_amount. This
assertion does indeed pass, and we have finished testing our accept
money method.
=end


=begin
CONCEPT
- To set the amount paid in transaction, we should use the amount_paid
  attr_setter rather than use prompt_for_payment to avoid introducing 
  additional complications (compared answer vs my solution) (VERY IMPORTANT)

- All test methods need to be prepended with test_ (IMPORTANT)

- The aim of the test is to test the change is total_money equal amount
  paid in transaction object
=end