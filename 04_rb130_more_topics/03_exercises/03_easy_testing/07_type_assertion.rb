=begin

Type Assertions

Write a minitest assertion that will fail if value is not an instance of the
Numeric class exactly. value may not be an instance of one of Numeric's superclasses.

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def test_instance_of
    assert_instance_of(Numeric, 3)  # 3 is of Integer class, a subclass of Numeric
  end
  
  def test_instance_of_2
    assert_instance_of(Integer, Numeric.new)  # Numeric is superclass of Integer
  end
  
  def test_instance_of_3
    assert_instance_of(Integer, 3)  #pass
  end
end


=begin
Solution

assert_instance_of Numeric, value

Discussion

#assert_instance_of uses Object#instance_of? to ensure that its
second argument is an instance of the class named as its first argument.
=end


=begin

TO REVIEW (IMPORTANT)

- The first argument to assert_instance_of is the expected class, the second argument
  is the object to be tested

- If the object is from a subclass or parent class, the test will still fail

=end