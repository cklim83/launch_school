=begin
Using the following code, determine the lookup path used when
invoking cat1.color. Only list the classes that were checked
by Ruby when searching for the #color method.

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color
=end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new('Black')
cat1.color
puts Cat.ancestors

=begin
My answer:
p Cat.ancestors # => [Cat, Animal, Objects, Kernel, BasicObjects]
The search started at Car since cat1 is an object of Cat. It also 
ended at Cat since Cat class inherited the #color method 
from Animal class. Cat#color was invoked.
=end


=begin
Solution

Cat
Animal

Discussion

When a method is invoked, Ruby searches the method's class for the
specified method. If no method is found, then Ruby inspects the
class's superclass. This process is repeated until the method is
found or there are no more classes.

To find the lookup path for a class, simply invoke #ancestors on
the class. This method returns an array containing the names of the
classes in the lookup path, based on the order in which they're checked.


CONCEPT
- Ruby search BOTH Cat and Animal before finding #color method and not
  just Cat alone since Cat didnt implement #color method but inherit 
  it from Animal
=end