=begin
Consider the following program.

class Pet
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch

Update this code so that when you run it, you see the following output:

My cat Pudding is 7 years old and has black and white fur.
My cat Butterscotch is 10 years old and has tan and white fur.
=end

class Pet
  attr_reader :name, :age
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Cat < Pet
  attr_reader :color
  
  def initialize(name, age, color)
    super(name, age)
    @color = color
  end
  
  def to_s
    "My cat #{name} is #{age} years old and has #{color} fur."
  end
end

pudding = Cat.new('Pudding', 7, 'black and white')
butterscotch = Cat.new('Butterscotch', 10, 'tan and white')
puts pudding, butterscotch


=begin
Solution

Update the Cat class as follows:

class Cat < Pet
  def initialize(name, age, colors)
    super(name, age)
    @colors = colors
  end

  def to_s
    "My cat #{@name} is #{@age} years old and has #{@colors} fur."
  end
end

Discussion

Since Cat#new requires arguments that differ from Pets#new, we must 
define an initialize method for Cat, and that method must be sure to
call super. Additionally, the fact that the two initialize methods
take different arguments also forces us to supply the correct arguments
to super.

Cat objects must respond appropriately to puts. The way to do this is
to override to_s to provide the appropriate value, which we do.

Further Exploration

An alternative approach to this problem would be to modify the Pet class to
accept a colors parameter. If we did this, we wouldn't need to supply an
initialize method for Cat.

Why would we be able to omit the initialize method? Would it be a good idea
to modify Pet in this way? Why or why not? How might you deal with some of
the problems, if any, that might arise from modifying Pet?

My answer:
If we modify Pet to include color in the initialization, we can just use
the initialize method inherited from Pet on colors so we do not need to define 
another one. It may be a good idea since all pets should have a color attribute.
However, it might be cumbersome to enter so many attributes. In that case,
maybe having a default value for color will mitigate this inconvenience.
=end