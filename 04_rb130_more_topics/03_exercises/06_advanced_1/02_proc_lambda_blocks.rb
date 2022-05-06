=begin

Exploring Procs, Lambdas, and Blocks: Definition and Arity

This exercise covers material that you do not have to master.
We provide the exercise as a way to explore the differences
between procs, lambdas, and blocks.

For this exercise, we'll be learning and practicing our knowledge
of the arity of lambdas, procs, and implicit blocks. Two groups of
code also deal with the definition of a Proc and a Lambda, and the
differences between the two. Run each group of code below: 

For your answer to this exercise, write down your observations for
each group of code. After writing out those observations, write one
final analysis that explains the differences between procs, blocks,
and lambdas.

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
my_lambda.call
my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }

# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
block_method_1('seal')

# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}

=end

# Group 1
my_proc = proc { |thing| puts "This is a #{thing}." }
puts my_proc
puts my_proc.class
my_proc.call
my_proc.call('cat')

=begin
My Observations
- Kernel#proc converts block argument to a Proc object. Upon
  checking documentation https://docs.ruby-lang.org/en/master/Kernel.html#method-i-proc,
  Kernel#proc { ... } is equivalent to Proc.new { ... }
- Proc#to_s returns string showing class and object_id and filename and line
- We invoke a proc using `call`
- Proc has lenient arity. The number of supplied arguments need not match the number of 
  parameters defined. 
  - If arguments are less than parameters, those parameters with no
    matching arguments will default to nil. No ArgumentError.
  - If arguments are more than parameters, the excess arguments are ignored. No ArgumentError.
=end


puts ""

# Group 2
my_lambda = lambda { |thing| puts "This is a #{thing}." }
my_second_lambda = -> (thing) { puts "This is a #{thing}." }
puts my_lambda
puts my_second_lambda
puts my_lambda.class
my_lambda.call('dog')
# my_lambda.call
# my_third_lambda = Lambda.new { |thing| puts "This is a #{thing}." }
# puts my_third_lambda
# puts my_third_lambda.class
# my_third_lambda.call('dog')
=begin
My observations:
- Two ways to define a lambda
  - lambda { ... }
  - -> (parameter) { ... }
- Lambda is also a type of proc
- Lambdas with equivalent code blocks have the same object_id
- Lambdas, unlike procs have hard arity. Argument mismatches with parameter
  list leads to ArgumentError. my_lambda.call raise this error
- There is no Lambda class defined, Lambda.new { ... } leads to uni NameError
  :uninitialize constant Lambda
=end

puts ""
# Group 3
def block_method_1(animal)
  yield
end

block_method_1('seal') { |seal| puts "This is a #{seal}."}
#block_method_1('seal')

=begin
Observations:
- All methods can accept a block
- Yield to a non-existing block leads to LocalJumpError. 
  Use Kernel#block_given? guard to make block optional if
  that is intended.
- Blocks have soft arity.
=end


puts ""
# Group 4
def block_method_2(animal)
  yield(animal)
end

block_method_2('turtle') { |turtle| puts "This is a #{turtle}."}
block_method_2('turtle') do |turtle, seal|
  puts "This is a #{turtle} and a #{seal}."
end
block_method_2('turtle') { puts "This is a #{animal}."}


=begin

Solution

Group 1:

    A new Proc object can be created with a call of proc instead of Proc.new
    A Proc is an object of class Proc
    A Proc object does not require that the correct number of arguments are passed to it. If nothing is passed, then nil is assigned to the block variable.

Group 2

    A new Lambda object can be created with a call to lambda or ->. We cannot create a new Lambda object with Lambda.new
    A Lambda is actually a different variety of Proc.
    While a Lambda is a Proc, it maintains a separate identity from a plain Proc. This can be seen when displaying a Lambda: the string displayed contains an extra "(lambda)" that is not present for regular Procs.
    A lambda enforces the number of arguments. If the expected number of arguments are not passed to it, then an error is thrown.

Group 3

    A block passed to a method does not require the correct number of arguments. If a block variable is defined, and no value is passed to it, then nil will be assigned to that block variable.
    If we have a yield and no block is passed, then an error is thrown.

Group 4

    If we pass too few arguments to a block, then the remaining ones are assigned a nil value.
    Blocks will throw an error if a variable is referenced that doesn't exist in the block's scope.

Comparison

    Lambdas are types of Proc's. Technically they are both Proc objects. An implicit block is a grouping of code, a type of closure, it is not an Object.
    Lambdas enforce the number of arguments passed to them. Implicit blocks and Procs do not enforce the number of arguments passed in.

=end


=begin
CONCEPTS (VERY IMPORTANT)
- to include in notes

=end