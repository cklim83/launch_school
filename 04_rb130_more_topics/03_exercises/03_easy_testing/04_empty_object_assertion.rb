=begin

Empty Object Assertions

Write a minitest assertion that will fail if the Array list is not empty.

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_assert_empty_array
    # assert_includes([], Object)
    assert_empty(1)
  end
end


=begin
Solution

assert_empty list

Discussion

#assert_empty tests whether its first argument responds to the method #empty?
with a true value. You can use:

assert_equal true, list.empty?

instead, but #assert_empty is clearer and issues a better failure message.
=end


=begin
TO REVIEW
- There is an #assert_empty(obj, msg=nil) method that calls #empty? on the
  object and fails if the return value is not true
  
  See http://docs.seattlerb.org/minitest/Minitest/Assertions.html
=end