=begin

Perfect Number

The Greek mathematician Nicomachus devised a classification scheme for natural
numbers (1, 2, 3, ...), identifying each as belonging uniquely to the
categories of abundant, perfect, or deficient based on a comparison between the
number and the sum of its positive divisors (the numbers that can be evenly
divided into the target number with no remainder, excluding the number itself).
For instance, the positive divisors of 15 are 1, 3, and 5. This sum is known as
the Aliquot sum.

    Perfect numbers have an Aliquot sum that is equal to the original number.
    Abundant numbers have an Aliquot sum that is greater than the original 
    number.
    Deficient numbers have an Aliquot sum that is less than the original number.

Examples:

    6 is a perfect number since its divisors are 1, 2, and 3, and 1 + 2 + 3 = 6.
    
    28 is a perfect number since its divisors are 1, 2, 4, 7, and 14 
    and 1 + 2 + 4 + 7 + 14 = 28.
    
    15 is a deficient number since its divisors are 1, 3, and 5 
    and 1 + 3 + 5 = 9 which is less than 15.
    
    24 is an abundant number since its divisors are 1, 2, 3, 4, 6, 8, and 12
    and 1 + 2 + 3 + 4 + 6 + 8 + 12 = 36 which is greater than 24.
    
    Prime numbers 7, 13, etc. are always deficient since their only divisor is 
    1.

Write a program that can tell whether a number is perfect, abundant, or 
deficient.

=end


=begin
Problem
- input: a natural number (positive integer)
- output: 'perfect', 'abundant' or 'deficient' when sum of divisors, excluding
          the number itself is ==, > or smaller than the number itself

Examples and Test Cases
- 6: factors = [1, 2, 3]. Sum of factors = 6 == number itself, return 'perfect'
- 28: factors = [1, 2, 4, 7, 14], sum of factors = 28 == number itself, return 
      'perfect' 
    
- 15: factors = [1, 3, 5], sum of factors = 9 < number itself, return 
      'deficient' 
    
- 24: factors = [1, 2, 3, 4, 6, 8, 12], sum of factors = 36 > number itself, 
      return 'abundant'
    
    
All prime numbers 7, 13, etc. are always deficient since their only divisor is 
1.

Test Cases
- We need to create a class named PerfectNumber
- It needs a class method call classify that accepts a natural number argument
  and return either 'perfect', `deficient` or `abundant`
- If input is not a natural number i.e. integer >= 1, raise StandardError
- Edge case: input is 1, factors will be empty. what to return?

Data Structure
- input: integer
- ouput: string
Need an array to store the factors upto but excluding the number itself

Algorithm
1. raise StandardError unless valid?
2. set factors = []
3. Iterate from curr_number from 1..number/2
     append curr_number to factors if number % curr_number == 0
4. if sum of factors > number return 'abundant'
   elsif sum of factors == number return 'perfect'
   else return 'deficient'

valid?(number)
1. return number.instance_of Integer && number >= 1 

=end

class PerfectNumber
  def self.classify(number)
    raise StandardError unless valid?(number)
    
    factors = []
    (1..(number/2)).each do |curr_num| 
      factors << curr_num if number % curr_num == 0
    end
    
    category(factors, number)
  end
  
  private
  
  def self.valid?(number)
    number.instance_of?(Integer) && number >= 1
  end
  
  def self.category(factors, number)
    factors_sum = factors.sum  # factors_sum is 0 if factors = []
    
    if factors_sum > number
      'abundant'
    elsif factors_sum == number
      'perfect'
    else
      'deficient'
    end
  end
end


=begin
PEDAC Solution

Understanding Problem
  For our program, the details we need to keep in mind are as follows:

    We'll be given a number and we need to determine whether it is abundant,
    perfect, or deficient.
    
    Perfect: Sum of factors = number
    Abundant: Sum of factors > number
    Deficient: Sum of factors < number
    
    Factors are the numbers less than the input number that can be evenly
    divided into it. For example, the number 6 can be evenly divided by 1, 2,
    and 3.


Examples / Test Cases
  From the test cases shown above, we can see that we need to create a
  PerfectNumber class. The class should have 1 method:

    It accepts a number as an argument and returns the appropriate string
    based on its classification: "perfect", "abundant", or "deficient".

  We can also see that we need to throw an error when the input to the above
  method is a negative number.

  We may also want to create some helper methods to assist us, but those are
  optional.
  

Data Structure
In addition to working with numbers, it may also be helpful to use a
collection that can hold a range. This could prove useful in finding
all of the divisors of a given number.


Hints/Questions
    Throw an error if the input is negative
    How can we efficiently find all of the factors of the given number?
    We also need to sum all of the factors.
    Once we have the sum, we can classify the number and return the result.
    A number is a divisor of another number if the remainder of dividing the
    second number by the first is 0. For example, 7 is a divisor of 21 since
    21 % 7 is 0. However, 7 is not a divisor of 23 since 23 % 7 is not 0 -- it
    is 2.


Algorithm
    Method: classify
        Throw error if the argument is less than 1.
        Find the sum of all factors of argument (helper method)
        If sum is equal to argument, return "perfect".
        If sum is greater than argument, return "abundant".
        If sum is less than argument, return "deficient".

    Helper Method: determine sum of factors
        Initialize sum to 0
        Iterate over numbers from 1 up to 1 less than the argument.
            If number is a divisor of the argument, add number to sum
        Return sum
        
        
Solution and Discussion

class PerfectNumber
  def self.classify(number)
    raise StandardError.new if number < 1
    sum = sum_of_factors(number)

    if sum == number
      'perfect'
    elsif sum > number
      'abundant'
    else
      'deficient'
    end
  end

  class << self
    private

    def sum_of_factors(number)
      (1...number).select do |possible_divisor|
        number % possible_divisor == 0
      end.sum
    end
  end
end

In our example cases, we could see that we needed to create a class method, so
no constructor was needed. First, we make sure to raise an error if the input
is negative. Then, we use our helper method sum_of_factors to calculate the sum
of all the divisors.

Within the helper method, we iterate over 1 up to one less than the given
number. We select numbers from this range that are even divisors using the
modulo, and then we add all of the selected numbers using sum.

Note that our sum_of_factors helper method is a class (or static) method. We'd
like the method to be private since it's of no use to the users of our class.
Unfortunately, this code won't work as expected:

class PerfectNumber
  # omitted code

  private

  def self.sum_of_factors(number)
    (1...number).select do |possible_divisor|
      number % possible_divisor == 0
    end.sum
  end
end

Even though it looks like we're creating a private method, the private method
doesn't work on class methods -- it only works on instance methods. Fortunately,
there is a way around that using the class << self idiom lets us operate on the
class itself as an object; by adding a private instance method to the class
object, we effectively create a private class method. Why this works isn't
important at this stage, but it's a useful idiom to know.

Back in classify, we use this sum to determine the classification of the number.
=end


=begin

CONCEPT
- We CANNOT define a private class method using the typical

class ClassName
  ...
  
  private
  
  def self.my_pte_method
    ...
  end
end

- ClassName.my_pte_method is still a PUBLIC class method
- We can create a private class equivalent by wrapping the private section 
  within class << self ... end, this within PerfectNumber class

  class << self
    private

    def sum_of_factors(number)
      ...
    end
  end

- There is a #select for range objects 

=end





