=begin

Equality Assertions

Write a minitest assertion that will fail if value.downcase
does not return 'xyz'.
=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_assert_equal
    assert_equal 'xyz', 'AAA'.downcase , "AAA.downcase does not equal xyz"
  end
end


=begin
Solution

assert_equal 'xyz', value.downcase

Discussion

#assert_equal tests whether its first two arguments are equal using #==.
Failure messages issued by #assert_equal assume that the first argument
represents the expected value, while the second argument represents the
actual value to be tested. It's important to maintain this convention so
that failure messages make sense.
=end


=begin

CONCEPTS TO REVIEW (IMPORTANT)

- For #assert_equal, the first argument should be the expected value
  and the second argument is the actual value from executed function 
  that we are testing 

- assert_equal uses #== of the arguments under the hood to do the 
  comparison. If the argument objects are custom class, we need to
  implement #== else it will use BasicObject#== (from inheritance)
  which returns true only if both are the same object. 
  
=end