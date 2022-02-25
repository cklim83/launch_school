=begin
Assume you have the following code:

class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
end

home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1

and this output:

Home 1 is cheaper
Home 2 is more expensive

Modify the House class so that the above program will work
You are permitted to define only one new method in House.

Hint: You may find the Comparable module useful.
=end

class House
  attr_reader :price

  def initialize(price)
    @price = price
  end
  
  def >(other_house)
    price > other_house.price
  end
  
  def <(other_house)
    price < other_house.price
  end
end

# Preferred way: using Comparable module
# https://docs.ruby-lang.org/en/master/Comparable.html
# Comparable has various comparison instance methods 
# but require the class to implement <=> method

class House
  include Comparable
  
  attr_reader :price

  def initialize(price)
    @price = price
  end
  
  def <=>(other)
    price <=> other.price
  end
end


home1 = House.new(100_000)
home2 = House.new(150_000)
puts "Home 1 is cheaper" if home1 < home2
puts "Home 2 is more expensive" if home2 > home1


=begin
Solution

class House
  attr_reader :price
  include Comparable

  def initialize(price)
    @price = price
  end

  def <=>(other)
    price <=> other.price
  end
end

...

Discussion

Making objects comparable is actually quite easy; you don't have to create
every possible comparison operator for the object. Instead, all you need
to do is include the Comparable mixin, and define one method: <=>. The <=>
method should return 0 if the two objects are "equal", 1 if the receiving
object is greater than the other object, and -1 if the receiving object is
less than the other object. Often, as here, the comparison will boil down
to comparing numbers or strings, both of which already have a <=> operator
defined. Thus, you rarely have to write an involved #<=> method.

Further Exploration

Is the technique we employ here to make House objects comparable a good one?
(Hint: is there a natural way to compare Houses? Is price the only criteria
you might use?) What problems might you run into, if any? Can you think of
any sort of classes where including Comparable is a good idea?

My answer:
Using only prices to compare Houses may not be appropriate. Other factors
such as size, location and age may also be contributing factors.


CONCEPTS
- Using Comparable mixin
=end