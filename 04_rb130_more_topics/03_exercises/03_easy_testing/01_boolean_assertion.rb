=begin

Boolean Assertions

Write a minitest assertion that will fail if the value.odd? is not true.

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_1
    assert_equal(true, 3.odd?)
    assert(2.odd?, "Assert 2.odd? not equal true")
    
    assert_equal(true, 2.odd? , "Assert equal 2.odd? not equal true")
  end
  
  def test_2
    assert(true)
  end
end

=begin
Solution

assert value.odd?, 'value is not odd'

Discussion

#assert tests whether its first argument is truthy (that is, it is neither
false nor nil). If the first argument is not truthy, the test fails, and
the second argument is displayed as the failure message.

Most (but not all) of the minitest assertions let you specify a failure
message as the final argument. This is frequently omitted since the error
messages provided by default are usually sufficient. However, the default
message for assert lacks context, so it is common to specify the failure
message when using assert.

assert isn't used directly in most tests since it is usually more important
to ensure an exact value is returned; if you want to know that your method
returns true and not just a truthy value, assert_equal is a better choice.

For example:

assert_equal true, value.odd?
=end


=begin
To REVIEW (IMPORTANT)
- #assert, #assert_equal should be used within with require 'minitest/autorun'
  and within a test_ method, else a NoMethodError will result

- Our test class should inherit from Minitest::Test

- Our test method should begin with test_, else it wont run.

- #assert and #assert_equal both takes an optional string as second parameter 
  to display failure message. The parenthesis to #assert or #assert_equal is
  optional.

- Within a test, once an assertion failure occurs, subsequent assertions below
  the failed one are not executed. Subsequent tests (i.e. runs) are still
  executed however. My code above yields
  
  Run options: --seed 34580

# Running:

F.

Finished in 0.002336s, 856.0786 runs/s, 1284.1179 assertions/s.

  1) Failure:
MyTest#test_1 [01_boolean_assertion.rb:14]:
Assert 2.odd? not equal true

2 runs, 3 assertions, 1 failures, 0 errors, 0 skips
=end