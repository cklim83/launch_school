=begin

Included Object Assertions

Write a minitest assertion that will fail if the 'xyz' is not in the Array
list.

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_assert_includes
    assert_includes([1,2,3], "xyz")
  end
end


=begin
Solution

assert_includes list, 'xyz'

Discussion

#assert_includes tests whether its first argument contains the second argument. You can use:

assert_equal true, list.include?('xyz')

instead, but #assert_includes is clearer and issues a better failure message.
=end


=begin
TO REVIEW
- It is #assert_includes with an s, i.e. not #assert_include
=end