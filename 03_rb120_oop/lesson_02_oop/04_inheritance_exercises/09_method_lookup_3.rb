=begin
Using the following code, determine the lookup path used when
invoking bird1.color. Only list the classes or modules that
were checked by Ruby when searching for the #color method.

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color
=end

=begin
My answer:

Bird
Flyable
Animal
=end


=begin
Solution

Bird
Flyable
Animal

Discussion

This exercise is similar to the previous one, however,
now the module Flyable has been mixed-in. How does that
affect the lookup path? When a module is included in a
class, the class is searched before the module. But, the
module is searched before the superclass. This order of
precedence applies to all modules and classes in the
inheritance hierarchy.


CONCEPT
- When a class includes a module and inherits from a superclass,
  method lookup first take place at that class, then module
  then superclass in that order

- In that class include >1 module, the last included
  module is searched first, then the second last ... up till
  the first before the parent class
=end