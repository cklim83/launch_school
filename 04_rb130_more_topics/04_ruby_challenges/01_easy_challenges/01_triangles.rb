=begin

Triangles

Write a program to determine whether a triangle is equilateral, isosceles,
or scalene.

An equilateral triangle has all three sides the same length.

An isosceles triangle has exactly two sides of the same length.

A scalene triangle has all sides of different lengths.

Note: For a shape to be a triangle at all, all sides must be of length > 0,
and the sum of the lengths of any two sides must be greater than the length
of the third side.
=end

=begin
Problem
- All sides of a triangle have lengths > 0
- Sum of length of any two sides of a triangle must be greater than the third
- Equilateral triangle have sides of same length
- Isosceles triangles have 2 sides of same length
- Scalene triangles have all sides with different lengths

Examples
- Triangle.new([4, 5, 6])  => :scalene
- Triangle.new([5, 5, 5])  => :equilateral
- Triangle.new([7, 7, 10]) => :isoceles
- Triangle.new([4, 0, 10]) => InvalidTriangleError, one side is 0
- Triangle.new([10, 4, 4]) => InvalidTriangleError, sum of smallest 2 sides < third side

Data Structure
- input: array containing 3 lengths
- output: :scalene, :equilateral, :isosceles, InvalidTriangleError

Algorithm
1. Call validate in constructor
   - Raise InvalidTriangleError is any sides is 0
   - Sort sides in ascending order, raise InvalidTriangleError is sum of first 2 elements is smaller or equal to third element
   - Set @side_a, @side_b, @side_c = sides 
2. Define #equilateral?
   -  @side_a == @side_b && @side_b == @side_c
3. Define #isoceles?
   - !equilateral? && @side_a == @side_b || @side_b == @side_c
4. Define #scalene?
   - !equilateral? && !isosceles?
5. Define #type
   - case
     when equilateral? then :equilateral
     when isosceles? then :isosceles
     else :scalene
=end

class Triangle
  attr_reader :sides
  def initialize(a, b, c)
    @sides = validate(a, b, c)
  end
  
  def kind
    case sides.uniq.size
    when 1 then 'equilateral'
    when 2 then 'isosceles'
    else 'scalene'
    end
  end
  
  private
  
  def validate(*lengths)
    lengths.sort!
    
    invalid_check = lengths.any? { |length| length <= 0 } ||
                    lengths[0] + lengths[1] <= lengths[2]
    raise ArgumentError if invalid_check
    
    lengths
  end
end


=begin
Solution

1 (P)EDAC - Understand the problem

 Important details we need to keep in mind:

  To be a valid triangle, each side length must be greater than 0.
  To be a valid triangle, the sum of the lengths of any two sides must be greater than the length of the remaining side.
  An equilateral triangle has three sides of equal length.
  An isosceles triangle has exactly two sides of the equal length.
  A scalene triangle has three sides of unequal length (no two sides have equal length).

  
2 P(E)DAC - Examples and Test Cases

 The provided test cases indicate that we need a Triangle class. We see that the class must have the following two methods:

    a constructor that accepts three arguments representing three side lengths.
        an exception is raised in the constructor if any side length is <= 0.
        an exception is raised if the side lengths taken together don't describe a valid triangle

    a method kind that returns a string representing the type of the triangle.

 We may also want to create some helper methods to assist us, but those are optional.


3. PE(D)AC - Data Structures

 We can see from the provided test cases that we are going to be using numbers to create a new triangle and to determine its validity and type. The return value is a string.

 What we need to think about how we might store a triangle's side lengths. It might be convenient to collect the three side-lengths into an array.


4. PED(A)C - Algorithms

 constructor

    Save the three side lengths
    Check whether any side length is less than or equal to zero. If so, raise an exception.
    Use comparisons to determine whether the sum of any two side lengths is less than or equal to the length of the third side. If so, raise an exception.

 Method: kind

    Compare the values representing the three side lengths
    If all three side lengths are equal return 'equilateral'.
    If the triangle is not equilateral, but any two side lengths are equal to one another, return 'isosceles'.
    If none of the side lengths are equal to one another, return 'scalene'.
    
    
Hints
  The constructor should check whether all 3 side lengths are > 0 and whether the side lengths taken together form a valid triangle.


5. PEDA(C) - Code with Intent

class Triangle
  attr_reader :sides

  def initialize(side1, side2, side3)
    @sides = [side1, side2, side3]
    raise ArgumentError.new "Invalid triangle lengths" unless valid?
  end

  def kind
    if sides.uniq.size == 1
      'equilateral'
    elsif sides.uniq.size == 2
      'isosceles'
    else
      'scalene'
    end
  end

  private

  def valid?
    sides.min > 0 &&
    sides[0] + sides[1] > sides[2] &&
    sides[1] + sides[2] > sides[0] &&
    sides[0] + sides[2] > sides[1]
  end
end

In our constructor, we place all of our side lengths into an array to make it simpler
to pass around and for easy access to Array methods. After doing so, we ensure that
we raise an ArgumentError unless the three sides would create a valid triangle.

We extract this validation into its own helper method: valid?. First, we ensure that
none of the sides are 0 or less, and then we ensure that any two sides sum to a number
greater than or equal to the remaining side.

Inside kind, we take a shorter logic approach. If all sides are equal, then there will
only be one unique number in the sides array; thus, it's an equilateral. If two sides
are equal, then there will be two unique numbers in the sides array; thus it's an
isosceles. In all other cases — where all three sides are of differing lengths — it's
a scalene triangle.

=end