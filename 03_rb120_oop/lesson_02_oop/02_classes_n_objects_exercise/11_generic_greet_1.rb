=begin
Modify the following code so that Hello! I'm a cat!
is printed when Cat.generic_greeting is invoked.

class Cat
end

Cat.generic_greeting

Expected output:

Hello! I'm a cat!
=end

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

kitty = Cat.new
kitty.class.generic_greeting



=begin
Solution

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

Cat.generic_greeting

Discussion

When looking at the initial example, the first thing you should notice
is the invocation of ::generic_greeting. It's being invoked on the Cat
class, not an instance of Cat. This indicates that ::generic_greeting
is a class method.

Class methods are defined differently than instance methods. When
defining a class method, the method name is prepended with self,
like this: self.generic_greeting. In the solution, self refers to
the Cat class. This means we could also define #generic_greeting
as Cat.generic_greeting. However, self is preferred when defining
class methods.

Like instance methods, we can place any statement we want inside a
class method. In our solution, we place puts 'Hello! I'm a cat!' so
that Hello! I'm a cat! is printed when ::generic_greeting is invoked.

To invoke class methods, they must be called on the class itself,
not an instance of the class. If we invoke a class method on an
instance of the class, we'll get a NoMethodError:

class Cat
  def self.generic_greeting
    puts "Hello! I'm a cat!"
  end
end

kitty = Cat.new
kitty.generic_greeting # => undefined method `generic_greeting' for
#<Cat:0x007fbdd3875e40> (NoMethodError)

Further Exploration

What happens if you run kitty.class.generic_greeting? Can you explain
this result?

My answer:
We get same result as invoking the class method using the class. This
is because kitty.class returns 'Cat' which we then call generic_greeting
on.


CONCEPTS
- A method called on the class is a class method
- A class method has a self.prepended before the method name unlike
  an instance method. 
- self outside an instance method inside a class
  definition is refers to the class itself.
=end