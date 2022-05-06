=begin

Kind Assertions

Write a minitest assertion that will fail if the class of value is not
Numeric or one of Numeric's subclasses (e.g., Integer, Float, etc).

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_assert_type
    assert_kind_of(Numeric, '3')
  end
end


=begin
Solution

assert_kind_of Numeric, value

Discussion

#assert_kind_of uses Object#kind_of? to check if the class of its second
argument is an instance of the named class or one of the named class's subclasses.
=end

=begin
TO REVIEW
- #assert_kind_of calls the #kind_of method from the test object to see if
  it belongs to the expected class or its subclasses.
  
=end