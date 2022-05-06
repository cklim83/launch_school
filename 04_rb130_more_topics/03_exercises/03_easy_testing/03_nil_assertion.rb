=begin

Nil Assertions

Write a minitest assertion that will fail if value is not nil.
=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_nil_assertion
    assert_nil("hello")
  end
end


=begin
Solution

assert_nil value

Discussion

#assert_nil tests whether its first argument is nil. You can use:

assert_equal nil, value

instead, but #assert_nil is clearer and issues a better failure message.
=end