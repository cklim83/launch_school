=begin

Passing Parameters Part 3

Given this code:

items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

Fill out the following method calls for gather so that they produce the
corresponding output shown in numbers 1-4 listed below:

1)

gather(items) do | , |
  puts
  puts
end

Let's start gathering food.
apples, corn, cabbage
wheat
We've finished gathering!

2)

gather(items) do | , , |
  puts
  puts
  puts
end

Let's start gathering food.
apples
corn, cabbage
wheat
We've finished gathering!

3)

gather(items) do | , |
  puts
  puts
end

Let's start gathering food.
apples
corn, cabbage, wheat
We've finished gathering!

4)

gather(items) do | , , , |
  puts
end

Let's start gathering food.
apples, corn, cabbage, and wheat
We've finished gathering!
=end


items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end

gather(items) do |*fruits_vegetables, carbo |
  puts fruits_vegetables.join(", ")
  puts carbo
end

# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!


gather(items) do | fruit, *vegetables , carbo |
  puts fruit
  puts vegetables.join(", ")
  puts carbo
end

# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!


gather(items) do | fruit, *others |
  puts fruit
  puts others.join(", ")
end

# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!


gather(items) do | fruit, veg_1, veg_2 , staple |
  puts "#{fruit}, #{veg_1}, #{veg_2} and #{staple}"
end

# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!


=begin
Solution

# 1
gather(items) do |*produce, wheat|
  puts produce.join(', ')
  puts wheat
end

# 2
gather(items) do |apples, *vegetables, wheat|
  puts apples
  puts vegetables.join(', ')
  puts wheat
end

# 3
gather(items) do |apples, *assorted|
  puts apples
  puts assorted.join(', ')
end

# 4
gather(items) do |apples, corn, cabbage, wheat|
  puts "#{apples}, #{corn}, #{cabbage}, and #{wheat}"
end

Discussion

This isn't necessarily just an exercise related to blocks, but how Ruby handles
passing parameters in different situations. We can make equivalent code that
gives us the same output, if we make changes to gather method for each
numbered problem(1-4).

# 1
def gather(*produce, wheat)
  puts "Let's start gathering food."
  p produce
  puts wheat
  puts "We've finished gathering!"
end

# 2
def gather(apples, *vegetables, wheat)
  puts "Let's start gathering food."
  puts apples
  p vegetables
  puts wheat
  puts "We've finished gathering!"
end

# 3
def gather(apples, *assorted)
  puts "Let's start gathering food."
  puts apples
  p assorted
  puts "We've finished gathering!"
end

# 4
def gather(apples, corn, cabbage, wheat)
  puts "Let's start gathering food."
  puts "#{apples}, #{corn}, #{cabbage}, and #{wheat}"
  puts "We've finished gathering!"
end

# method call

gather(*items) # notice we need a splat operator for passing in that array now.

The calls for outputting our variables are the same, we can even move the block
parameters and make them our method parameters. For calling this new gather
method, we have to use *items instead of just items as an argument. Using *items
passes each array element as a list of items instead of a bundled array of items.
Having to define four different methods though is cumbersome, using a block gives
us much more flexibility on how we want to group our output.

This has also shown us a key difference between how arrays are passed as
parameters either to a block or a method. When yielded to a block, an array's
individual elements will get converted to a list of items if the block parameters
call for that conversion(such as when we have parameters like |apples, *assorted|).

When passing an array to a method, we need to be explicit in how we pass it. If we
want to change that array into a list of items, we'll have to do so with the splat
operator *. Overall, it seems like using a block was the right way to go, it allows
us more flexibility and leaves the implementation of gather to the user.
=end


=begin

CONCEPT (VERY IMPORTANT)

- splat operator usage

- at method invocation or block yielding, a splat operator converts an array (n elements)
  argument into a list i.e. n arguments
  
- on the receiving end i.e. method/block parameter definition, a splat operator allow
  a parameter receive a list of arguments i.e. match a variable number of arguments.

- The splat operator can be used at the start, middle, tail of the parameter list 
  or not at all for a method definition or block
  
Key Difference between block and method
- In a method call, the splat operator has to be applied to an array argument during invocation
  so that the array can be converted to a list of elements instead of a bundled array of items
  to match the receiving parameters.
  
  def my_method(a, *b, c)
    p a
    p b
    p c
  end
  
  my_method(*[1, 2, 3])  => a = 1, b = [2], c = 3
  my_method(*[1, 2])     => a = 1, b = [], c = 2
  my_method([1, 2, 3])   => Argument error, given 1, expected 2+
  
- When yielded to a block, an array is automatically converted to a list of items even without
  applying the splat operator if the block parameters call for that 
  (i.e. some parameters in block has splat operator)
  
  def to_block(arr)
    yield(arr)
  end
  
  to_block([1, 2, 3, 4]) do |a, *b, c|
    p a
    p b
    p c
  end
  => a = 1, b = [2, 3], c = 4
  
  def to_block(arr)
    yield(*arr)
  end
  
  to_block([1, 2, 3, 4]) do |a, *b, c|
    p a
    p b
    p c
  end
  => a = 1, b = [2, 3], c = 4
=end