=begin

Fix the Bug

The following code:

def my_method(array)
  if array.empty?
    []
  elsif
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([])
p my_method([3])
p my_method([3, 4])
p my_method([5, 6, 7])

is expected to print:

[]
[21]
[9, 16]
[25, 36, 49]

However, it does not. Obviously, there is a bug. Find and fix the bug,
then explain why the buggy program printed the results it did.
=end

=begin
My answer:
The output of the original given program are:
[]
nil
nil
nil

This is because the elsif branch treats the return value of `Array#map` method call
as its conditional. As such, any non-empty input array, will return a non-empty array
to elsif which evaluates to true. Since there is no statement within this elsif branch, 
nil is returned.

The intended result is for single element arrays to enter the else branch and for multiple 
element arrays to enter the elsif branch. Hence the following will result in the intended result
=end

def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

p my_method([]) == []
p my_method([3]) == [21]
p my_method([3, 4]) == [9, 16]
p my_method([5, 6, 7]) == [25, 36, 49]


=begin
Solution

The program can be fixed by changing my_method to read:

def my_method(array)
  if array.empty?
    []
  elsif array.size > 1
    array.map do |value|
      value * value
    end
  else
    [7 * array.first]
  end
end

Discussion

This bug can be difficult to find since a first reading of the code is not
likely to notice the fact that elsif is missing a conditional expression.
If you don't notice that right away, you can spend a long time looking at
this program trying to figure out why it isn't working. Even once you spot
the problem, it can take a few minutes just to understand why the program
runs at all; if you don't run the code yourself, you may not believe that
it runs.

Anyway, that missing conditional expression on the elsif isn't really
missing -- at least not as far as the ruby parser is concerned. When ruby
gets to the end of the elsif line and doesn't find a conditional expression,
it's smart enough to go looking for it on the next line. Lo and behold,
there's the conditional expression.

What conditional expression, you ask? Why, the one that begins with
array.map do |value|; that's right, that map call (including the associated
block) is a conditional expression. And, it's value is truthy. Actually,
the value of a map is the Array returned by map, and an Array is always true.
Thus, any time the array is non-empty, the elsif branch gets executed.

What elsif branch? If the map call is the conditional expression, where's the
code that gets executed in that branch? The answer is that there is no code,
but a branch doesn't need to have any code. If there is no code in a branch,
then it's equivalent to the expression nil. This is why my_method always
returns nil instead of an Array when the input array isn't empty.

Fixing this is easy once the problem has been identified. It's just a matter
of figuring out what conditional expression should be passed to the elsif.
From looking at the inputs and expected outputs, we can see that any Array
of size greater than 1 should take the elsif path, so the correct conditional
is array.size > 1.

Actually, there are other possible conditions you can use on the elsif that
would work as well. array.size > 1 is merely one reasonable answer, and
perhaps the most logical.
=end


=begin
TO REVIEW
- an empty array [] is also truthy since !![] == true, something which i expect to
  be expect to be false
- a conditional branch without code is equivalent to a `nil` expression.
=end