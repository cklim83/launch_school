require 'minitest/autorun'
require_relative 'cash_register'

class Test_CashRegister < Minitest::Test
  def setup
  end
end


=begin
Solution

require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test
end

Discussion

Here's what we need to set up our test class for CashRegister.
First, we need to require all necessary libraries and files.
"minitest/autorun" is first on the list, as this is the library
that will give us access to certain parts of the minitest framework
that we need. We also need to require the class we want to test and
any classes it depends on. In this case, we want to test CashRegister,
but that class depends on collaboration with the Transaction class.
We've put those two classes in their own separate files, so two relative
requires are necessary to gain access to both classes. Finally, we have
to set up the correct testing class. By minitest convention, we'll be
naming this class "Class name we want to test"Test: this ends up being,
CashRegisterTest. We also have to make sure that our test class
subclasses from Minitest::Test. This is a very important step, since if
we didn't include this inheritance, then this would be a plain Ruby
class and not a test class.
=end


=begin
TO REVIEW
- need to include require "minitest/autorun" for the minitest library

- require_relative the source code for the source codes of the classes to be tested
  - require_relative imply the class source codes are in same directory as the test
    ruby file. We do not need to include .rb in the string argument for require/require_relative
    
  - Even though we want to test CashRegister class, Transaction class has to be
    included as it is a collaborator object in methods of CashRegister class (Important)

- When naming test class, it should "ClassWeAreTesting"Test in Camelcase (Important)

- We need to our test class to inherit from Minitest::Test
=end