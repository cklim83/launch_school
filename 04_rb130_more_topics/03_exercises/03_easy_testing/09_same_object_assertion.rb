=begin

Same Object Assertions

Write a test that will fail if list and the return value of
list.process are different objects.

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_same_object
    assert_same(list, list.process)
  end
end


=begin
Solution

assert_same list, list.process

Discussion

#assert_same tests whether its first and second arguments
are the same object, as determined by #equal?.
=end