=begin
Using the following code, add a method named #identify that
returns its calling object.

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

Expected output (yours may contain a different object id):

#<Cat:0x007ffcea0661b8 @name="Sophie">
=end

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end
  
  def identify
    self.inspect
  end
end

kitty = Cat.new('Sophie')
p kitty.identify


=begin
Solution

class Cat
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def identify
    self
  end
end

kitty = Cat.new('Sophie')
p kitty.identify

Discussion

In the last two exercises, we used self to define class methods
and to modify instance variables. self is used because it refers
to the calling object. This means that, in our solution, invoking
self is the same as invoking kitty.

p kitty.identify # => #<Cat:0x007f932b06dba8 @name="Sophie">
p kitty          # => #<Cat:0x007f932b06dba8 @name="Sophie">

We use #p to print the object so that #inspect is called, which
lets us view the instance variables and their values along with
the object.


CONCEPTS
- self in an instance method is equivalent to the object referenced by 
  the kitty variable
- p unlike puts will call inspect on its argument. puts will call 
  to_s which returns the class name and the encoded object_id. The object
  attributes are not returned. Inspect will also include the object attribute
- Since p will call inspect on its argument, we need not call inspect
  in the identify instance method.
=end