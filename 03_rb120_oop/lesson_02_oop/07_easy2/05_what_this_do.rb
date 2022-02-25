=begin
What will the following code print?

class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
puts Something.dupdata
puts thing.dupdata
=end

=begin
ByeBye
HelloHello
=end


=begin
Solution

ByeBye
HelloHello

Discussion

Here we see two methods named dupdata in the Something class.
However, one is defined as dupdata, and is thus an instance method.
The other is defined as self.dupdata, and is a class method. The
two methods are different, and are completely independent of each other.

Our code first creates a Something object, and then prints the result
of Something.dupdata, and then thing.dupdata. The former invocation
calls the class method (self.dupdata), and so prints "ByeBye". The
latter invocation calls the instance method, and so prints "HelloHello".


CONCEPTS
- class and instance method may have same names but they are different
  i.e. self.method_name != method_name
- No overriding of method applicable since they are different methods.
=end