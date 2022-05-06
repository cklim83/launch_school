=begin

Exception Assertions

Write a minitest assertion that will fail unless employee.hire
raises a NoExperienceError exception.

=end

require 'minitest/autorun'

class NoExperienceError < ::StandardError
end

class MyTest < Minitest::Test
  def test_assert_raises
    assert_raises(NoExperienceError) { employee.hire }
  end
end


=begin
Solution

assert_raises NoExperienceError do
  employee.hire
end

Discussion

#assert_raises checks if the given block raises an exception of
the named type. If it does not, the assertion fails.
=end