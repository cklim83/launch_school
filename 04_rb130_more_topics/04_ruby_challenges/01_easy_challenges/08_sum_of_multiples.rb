=begin

Sum of Multiples

Write a program that, given a natural number and a set of one or more other
numbers, can find the sum of all the multiples of the numbers in the set
that are less than the first number. If the set of numbers is not given, use
a default set of 3 and 5.

For instance, if we list all the natural numbers up to, but not including, 20
that are multiples of either 3 or 5, we get 3, 5, 6, 9, 10, 12, 15, and 18.
The sum of these multiples is 78.
=end


=begin
Problem
- input: a natural number as first argument, an optional set of 1 or more 
         numbers of used to generate the multiples. Defaults to [3, 5] if
         second argument no provided

- output: a number representing the sum of all multiples of numbers in the 
          second argument that are less than the first argument
          
          
Examples
- sum_multiples(20, [3, 5]) == 78, multiples = [3, 5, 6, 9, 10, 12, 15, 18]

Requirements
- 1st argument is a natural number, i.e. >= 1
- multiples have to be smaller than first argument
- multiples have no duplicates
- Edge condition: if 1st argument is 1, multiples have to be [], return 0?
- Can numbers in second argument be negative? Assume not since multiples
  are only positive number

Test Cases
- require SumOfMultiples class
- class method ::to(n) that accepts the upper limit and use [3, 5] as seed 
  for multiples. Returns sum of multiples
- an instance method to(n), that accepts the upper limit and use numbers 
  provided to constructor as seed for multiples. Returns sum of multiples
- edge condition of 1 to return 0
- The constructor accepts a list of numbers, not in array form. 
  
Data Structures
- input: array for the list of numbers
- output: integer
- an array to hold the valid multiples and for multiples like uniq and sum.


Algorithm
- Constructor
  - Accept a list of numbers
  
- ::to class method that accept n, the upper limit not to be included and an 
  optional list of numbers that seeds the multiples, defaults to [3, 5] if not
  provided
  - set multiples = []
  - iterate for each i from 1 ... upper_limit
    - iterate for each number in numbers
      value = i * number
      break if value >= upper_limit
      multiples << value
  - return sum of unique multiples

- to instance method
  call ::to(upper_limit, @numbers initialized in constructor)
=end

class SumOfMultiples
  def initialize(*numbers)
    @numbers = numbers
  end
  
  def self.to(upper_limit, numbers=[3, 5])
    multiples = []
    numbers.each do |number|
      (1...upper_limit).each do |i|
        value = number * i
        break if value >= upper_limit
        multiples << value
      end
    end
    
    multiples.uniq.sum
  end
  
  def to(upper_limit)
    self.class.to(upper_limit, @numbers)
  end
end


=begin
PEDAC solution

Understand Problem
  Some items from the instructions we want to keep in mind:

    We might be given a list of numbers for which we want to find the
    multiples, or we might not.
        If we are, we should use them as specififed.
        If we are not given the list, use 3 and 5 as the default list.
    We are also given a limiting value. We need to sum all of the multiples
    of the numbers in the list up to, but not including, the limiting value.


Examples and Test Cases
  From the test cases shown above, we can see that we need to create a
  SumOfMultiples class. The class should have 3 methods as follows:

    a constructor that takes the list of numbers for which we want to find the
    multiples. If the list is not specified, we should use 3 and 5.
    
    an instance method named to that computes the sum of all multiples of the
    list numbers that are less than argument passed to to.
    
    a class (or static) method that is also named to that does the same thing.
    However, this method has no way to define the list of numbers, so it always
    defaults to 3 and 5.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  We're definitely interacting with numbers, no matter our language of choice.
  It will also help to keep the multiples, however many they are, stored in a
  collection. An array will work well.
  
  
Hints and Questions
  We need two methods named to: one is an instance method, the other is a
  class or static method.

    The to instance method should first determine and save the multiples, then
    compute the sum of the multiples. Two iterations are better than one.

    The to class/static method can take advantage of the constructor and the to
    instance method.


Algorithm
  constructor

    If one or more arguments are given, save them as the list of numbers 
    for which we want the multiples.
    If no arguments are given, save 3 and 5 as the list of numbers.

  Method: to (instance method)

    Create an empty result collection.
    Takes one argument that gives the limiting value.
    Iterate from 1 through one less than the limiting value.
        Is the current number a multiple of one of the list of numbers?
            Yes: append it to the result collection.
    Initialize sum to 0.
    Iterate through the result collection.
        Add the current value to the sum.
    Return the sum.

  Method: to (class/static method)

    Accept one argument that gives the limiting value
    Create a new SumOfMultiples object with the default list of numbers.
    Call the new object's to method with the limiting value as an argument.
    Return the result of calling the new object's to method.


Ruby Solution and Discussion

class SumOfMultiples
  attr_reader :multiples

  def self.to(num)
    SumOfMultiples.new().to(num)
  end

  def initialize(*multiples)
    @multiples = (multiples.size > 0) ? multiples : [3, 5];
  end

  def to(num)
    (1...num).select do |current_num|
      any_multiple?(current_num)
    end.sum
  end

  private

  def any_multiple?(num)
    multiples.any? do |multiple|
      (num % multiple).zero?
    end
  end
end

Our constructor needs to check for an empty argument list -- if it is empty,
we default to [3, 5] as the list of multiples. Note that Ruby doesn't let us
use a default value with a splat parameter.

In the Ruby test cases, we can see that we need both a class and an instance
method. However, instead of duplicating the logic, we took advantage of the
instance method inside of the class method.

We created a helper method, any_multiple?, to take care of checking all of our
standard multiples against the current number in our iteration. any? is a nice
method to use since it stops iterating as soon as it finds a truthy return
value from the block.

We appended .sum at the end of the select method call within to so that we
didn't have to save the return value of select into its own variable. We
could've also used reduce here.

=end


=begin
CONCEPTS
- To avoid repeating code for similar logic class and instance methods, and to 
  allow users to call via either an instance method or same named class method,
  we can do one of the following:
  
  - In class method, instantiate an object, then use object to call the
    instance method (Given solution)
    
  - In the instance method, call the class method (my solution)
  
- A splat operator on the last argument cannot have default parameter
  def test(*arg=[2, 3])
    p arg
  end
  => SyntaxError
  
- Passing in no argument to a argument with splat operator will return
  an empty array
  
  def test2(*arg)
    p arg
  end
  
  test2 => []
=end

