=begin

Getting Things Done

We wrote a method for moving a given number of elements from one array to
another. We decide to test it on our todo list, but invoking move on line
11 results in a SystemStackError. What does this error mean and why does
it happen?

def move(n, from_array, to_array)
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']
=end

=begin
My answer:
We ran out of stack space. `move` works on recursion, by shifting 1 item each time
and calling itself again to shift 1 less item. Unfortunately, the lack of a stopping
condition caused the method to call itself infinite times, using up all the stack 
space and result in the SystemStackError. To fix this, we need a the recursion to stop
once n-1 == 0
=end

def move(n, from_array, to_array)
  to_array << from_array.shift
  move(n - 1, from_array, to_array) if n-1 > 0
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(5, todo, done)

p todo # should be: ['coffee with Tom']
p done # should be: ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']


=begin
Solution

def move(n, from_array, to_array)
  return if n == 0
  to_array << from_array.shift
  move(n - 1, from_array, to_array)
end

# Example

todo = ['study', 'walk the dog', 'coffee with Tom']
done = ['apply sunscreen', 'go to the beach']

move(2, todo, done)

p todo #=> ['coffee with Tom']
p done #=> ['apply sunscreen', 'go to the beach', 'study', 'walk the dog']

Discussion

We want to stop as soon as we have moved n elements from one array to the other, 
i.e. when n == 0. The code we have added on line 2 of the solution tells Ruby to
return from the method when that condition is met.

Further Exploration

What happens if the length of the from_array is smaller than n?

My answer:
We get nil inserted to the to_array.
=end


=begin
TO REVIEW
- Recursion base case should return a result to end the recursion whereas i try to stop 
  at a redundant call
  
=end