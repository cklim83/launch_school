=begin

Refutations

Write a test that will fail if 'xyz' is one of the elements in the Array list:

=end

require 'minitest/autorun'

class MyTest < Minitest::Test
  def setup
    @list = [1, 2, 'xyz', 3]
  end
  
  def test_refute_includes
    refute_includes(@list, 'xyz')
  end
  
  def test_refute_false
    refute false
  end
  
  def test_refute_nil
    refute nil
  end
  
  def test_refute_truthy
    refute 1
  end
end


=begin
Solution

refute_includes list, 'xyz'

Discussion

Most minitest assertions have a corresponding refutation method that fails
if the indicated condition is true: refute_equal is the opposite of assert_equal,
refute_kind_of is the opposite of assert_kind_of, etc. Thus, the refutation of
assert_includes is refute_includes.
=end


=begin
TO REVIEW

- refutes are similar to assert, except they expect a falsely result for test to pass.
=end