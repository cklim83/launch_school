=begin
Question 1

Let's do some "ASCII Art" (a stone-age form of nerd artwork from back in the days before computers had video screens).

For this practice problem, write a one-line program that creates the following output 10 times, with the subsequent line indented 1 space to the right:

The Flintstones Rock!
 The Flintstones Rock!
  The Flintstones Rock!

My answer:
10.times { |n| puts " "*n + "The Flintstones Rock!" }

Given answer:
10.times { |number| puts (" " * number) + "The Flintstones Rock!" }

TO REVIEW: num.times passes 0, 1 ..., num-1 as argument into the block and returns num when it completes.
(1..10).each { |n| p n } will pass 1, 2, .., 10 into block but will return the range object (1..10) since range objects are immutable
(Numbers, Boolean, Nil and Ranges are immutable https://launchschool.medium.com/variable-references-and-mutability-of-ruby-objects-4046bd5b6717.)

=end

10.times { |n| puts " "*n + "The Flintstones Rock!" }


=begin
Question 2

The result of the following statement will be an error:

puts "the value of 40 + 2 is " + (40 + 2)

Why is this and what are two possible ways to fix this?

My answer:
Type Error, implicit conversion from Integer to String. This arise as the
+ operator is trying to concatenate a String operand to its left with an Integer 
operand to its right.

Method 1 convert the Integer to string using .to_s before the concatenation
puts "the value of 40 + 2 is " + (40 + 2).to_s

Method 2: Using string interpolation
puts "the value of 40 + 2 is #{40+2}"

Method 3: 
puts format("the value of 40 + 2 is %d", 40+2)

Method 4:
puts "The value of 40 + 2 is %d" % (40+2)  -> Note: Same TypeError will result here if 40+2 is not in brackets as we will be doing String + 2 operation.


Given answer:
This will raise an error TypeError: no implicit conversion of Integer into String because (40+2) results in an integer and it is being concatenated to a string.

To fix this either call

(40+2).to_s

or use string interpolation:

puts "the value of 40 + 2 is #{40 + 2}"

=end

puts "the value of 40 + 2 is " + (40 + 2).to_s
puts "the value of 40 + 2 is #{40 + 2}"
puts format("the value of 40 + 2 is %d", 40 + 2)
puts "The value of 40 + 2 is %d" % (40 + 2)

=begin
Question 3

Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  divisor = number
  factors = []
  begin
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end until divisor == 0
  factors
end

Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. 
How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 
0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going 
into an infinite loop.

Bonus 1
What is the purpose of the number % divisor == 0 ?

Bonus 2
What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?

My answer:

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

Purpose of number % divisor == 0 is to ensure value of divisor is indeed a factor of number since only then will the remainder of number/divisor be zero
Purpose of factors before the method end is to return the reference of the factors array to the caller when the method ends.

Given answer:
Use a while condition for the loop:

while divisor > 0 do
  factors << number / divisor if number % divisor == 0
  divisor -= 1
end

Bonus Answer 1

Allows you to determine if the result of the division is an integer number (no remainder).

Bonus Answer 2
This is what is the actual return value from the method. Recall that without an explicit return 
statement in the code, the return value of the method is the last statement executed. If we omitted 
this line, the code would execute, but the return value of the method would be nil.


TO REVIEW: begin, end until loop construct. Return value of loop/while.
=end

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end
  factors
end

p factors(10)
p factors(0)
p factors(-10)


=begin
Question 4

Alyssa was asked to write an implementation of a rolling buffer. Elements are added 
to the rolling buffer and if the buffer becomes full, then new elements that are 
added will displace the oldest elements in the buffer.

She wrote two implementations saying, "Take your pick. Do you like << or + for 
modifying the buffer?". Is there a difference between the two, other than what 
operator she chose to use to add an element to the buffer?

def rolling_buffer1(buffer, max_buffer_size, new_element)
  buffer << new_element
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

def rolling_buffer2(input_array, max_buffer_size, new_element)
  buffer = input_array + [new_element]
  buffer.shift if buffer.size > max_buffer_size
  buffer
end

My answer:
rolling buffer1 is more efficient since the << operator modifies/mutates the buffer in-place.
The + operator in rolling_buffer2 creates a new array each time containing the original array 
content and the new element appended at the end. Hence there is copying of values involved in each method call.

Given answer:
Yes, there is a difference. While both methods have the same return value, in the first implementation, 
the input argument called buffer will be modified and will end up being changed after rolling_buffer1 returns. 
That is, the caller will have the input array that they pass in be different once the call returns. 
In the other implementation, rolling_buffer2 will not alter the caller's input argument.

TO REVIEW. My answer did not address the point that input for rolling_buffer1 mutates buffer input but
rolling_buffer2 does not but instead returns a new array, even though both methods have the same return value.
=end


=begin
Question 5

Alyssa asked Ben to write up a basic implementation of a Fibonacci calculator. A user passes in two numbers, 
and the calculator will keep computing the sequence until some limit is reached.

Ben coded up this implementation but complained that as soon as he ran it, he got an error. 
Something about the limit variable. What's wrong with the code?

limit = 15

def fib(first_num, second_num)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1)
puts "result is #{result}"

How would you fix this so that it works?

My answer:
limit is defined as a local variable and is not accessible within the scope of method fib, which creates it own scope. Hence,
we will encounter undefined local variable or method limit within the fib method.

To solve this, we can include limit as a parameter in fib method definition. 
Another way to solve it would be to define limit as a constant variable. That way it will be accessible within the fib method.
However, adding limit as a parameter is preferable as it given the method caller visibility and discretion the max limit each 
time fib method is called.

Given answer:


Ben defines limit before he calls fib. But limit is not visible in the scope of fib because fib is a method 
and does not have access to any local variables outside of its scope.
You can make limit an additional argument to the definition of the fib method and pass it in when you call fib.

=end

def fib(first_num, second_num, limit)
  while first_num + second_num < limit
    sum = first_num + second_num
    first_num = second_num
    second_num = sum
  end
  sum
end

result = fib(0, 1, 15)
puts "result is #{result}"


=begin
Question 6

What is the output of the following code?

answer = 42

def mess_with_it(some_number)
  some_number += 8
end

new_answer = mess_with_it(answer)

p answer - 8

My answer:
34 is printed.
First, numbers are immutable objects. Hence there is no way the method mess_with_it can mutate answer. 
Secondly, within mess_with_it, we simply reassign some_number variable to a new numbers object using += operator. 
We did not change where answer is pointing to in reassignment.

Given answer:
34

=end


=begin
Question 7

One day Spot was playing with the Munster family's home computer and he wrote a small program to mess with their demographic data:

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end

After writing this method, he typed the following...and before Grandpa could stop him, he hit the Enter key with his tail:

mess_with_demographics(munsters)

Did the family's data get ransacked? Why or why not?

My answer:
No. munsters consist of nested hashes. Hence demo_hash.values within method mess_with_demographics is still a hash with key value pairs. 
As such, the block following the each method is expecting two arguments, 1 for the hash key and another the hash value but instead only
receive 1. Hence there should be syntax error and no changes should have been made from code execution. 

Given answer:
Spot will find himself in the "dog" house for this one. The family's data is all in shambles now.

Why? Remember that in Ruby, what gets passed to a method isn't the value of the object. 
Under the hood, Ruby passes the object_id of each argument to the method. 
The method stores these object_id's internally in locally scoped (private to the method) 
variables (named per the method definition's parameter list).

So Spot's demo_hash starts off pointing to the munsters hash. His program could wind up 
replacing that with some other object id and then the family's data would be safe.

In this case, the program does not reassign demo_hash -- it just uses it as-is. 
So the actual hash object that is being messed with inside of the method IS the munsters hash.


TO REVIEW:

Two gaps in my understanding. First munsters.values return an Array containing inner hashes as its elements, not a hash.
Hence family_member variable holds the fully inner hash, not just the key. 

munsters.values
 => [{"age"=>32, "gender"=>"male"}, {"age"=>30, "gender"=>"female"}, {"age"=>402, "gender"=>"male"}, 
     {"age"=>10, "gender"=>"male"}, {"age"=>23, "gender"=>"female"}] 

Second, even if we iterate a hash using each and supply only 1 parameter to the block, the parameter will hold [key, value]
in each iteration and not have a syntax error.

:001 > a = {tom: 50, david: 30}
 => {:tom=>50, :david=>30} 
:002 > a
 => {:tom=>50, :david=>30} 
:003 > a.each do |key|
:004 >     p key
:005?>   end
[:tom, 50]
[:david, 30]

=end

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

def mess_with_demographics(demo_hash)
  demo_hash.values.each do |family_member|
    family_member["age"] += 42
    family_member["gender"] = "other"
  end
end


p munsters
mess_with_demographics(munsters)
p munsters


=begin
Question 8

Method calls can take expressions as arguments. Suppose we define a method called rps as follows, 
which follows the classic rules of rock-paper-scissors game, but with a slight twist that it 
declares whatever hand was used in the tie as the result of that tie.

def rps(fist1, fist2)
  if fist1 == "rock"
    (fist2 == "paper") ? "paper" : "rock"
  elsif fist1 == "paper"
    (fist2 == "scissors") ? "scissors" : "paper"
  else
    (fist2 == "rock") ? "rock" : "scissors"
  end
end

What is the result of the following call?

puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")



My answer:
puts rps(rps(rps("rock", "paper"), rps("rock", "scissors")), "rock")
puts rps(rps("paper", "rock"), "rock")
puts rps(paper", "rock")
puts "paper"
Therefore, print paper, return nil


Given answer:
"paper"

The outermost call is evaluated by determining the result of rps(rps("rock", "paper"), 
rps("rock", "scissors")) versus rock. In turn that means we need to evaluate the two 
separate results of rps("rock", "paper") and rps("rock", "scissors") and later combine 
them by calling rps on their individual results. Those innermost expressions will return 
"paper" and "rock", respectively. Calling rps on that input will return "paper". Which 
finally when evaluated against "rock" will return "paper".

=end


=begin
Question 9

Consider these two simple methods:

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

What would be the return value of the following method invocation?

bar(foo)

My answer:
Invoking foo will return 'yes', which will be the argument for bar.
Within bar, param will be "yes", which cause the conditional to evaluate to false, thus returning "no"
from the ternary operation. Final return value is thus "no"

Given answer:
"no"
This is because the value returned from the foo method will always be "yes" , and "yes" == "no" will be false.

=end

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end

bar(foo)