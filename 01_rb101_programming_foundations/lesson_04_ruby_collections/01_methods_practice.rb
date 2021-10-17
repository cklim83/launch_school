=begin
Practice Problem 1

What is the return value of the select method below? Why?

[1, 2, 3].select do |num|
  num > 5
  'hi'
end

My answer: 
`select` method looks at the return value of the block to determine
if an element of the collection, an array in this case, should be 
included in the new array to be returned. The return value of the 
block is based on the last statement of the block. In this example,
in every iteration, the block will return 'hi', a truthy value. 
Hence, every item will be returned in a new array
=> [1, 2, 3]


Given answer:
# => [1, 2, 3]

select performs selection based on the truthiness of the block's
return value. In this case the return value will always be 'hi', 
which is a "truthy" value. Therefore select will return a new 
array containing all of the elements in the original array.
=end


=begin
Practice Problem 2

How does count treat the block's return value? How can we find out?

['ant', 'bat', 'caterpillar'].count do |str|
  str.length < 4
end

My answer:
https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-count
Based on documentation, if a block is given, count returns the 
number of elements for which the block returns a true value. In 
this example, only 'ant' and 'bat' have a length of < 4, hence
count will return 2.


Given answer:


If we don't know how count treats the block's return value,
then we should consult the docs for Array#count. Our answer
is in the description:

    If a block is given, counts the number of elements for 
    which the block returns a true value.

Based on this information, we can conclude that count only 
counts an element if the block's return value evaluates as true.
This means that count considers the truthiness of the block's
return value.

=end


=begin
Practice Problem 3

What is the return value of reject in the following code? Why?

[1, 2, 3].reject do |num|
  puts num
end

My answer: 
https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-reject
Based on documentation, Array#reject returns a new array containing
the items in self (i.e. caller) for which the given block evaluates
to falsey.Since each item return nil after passing the block, a
falsey value, all items are included in the new array to be returned.
=> [1, 2, 3]


Given answer:
# => [1, 2, 3]

Since puts always returns nil, you might think that no values would
be selected and an empty array would be returned. The important thing
to be aware of here is how reject treats the return value of the block.
reject returns a new array containing items where the block's return
value is "falsey". In other words, if the return value was false or nil
the element would be selected.

=end


=begin
Practice Problem 4

What is the return value of each_with_object in the following code? Why?

['ant', 'bear', 'cat'].each_with_object({}) do |value, hash|
  hash[value[0]] = value
end

My answer:
each_with_object accepts an object as argument and also pass that
object as a second argument to be updated with the return value 
of the block before returning that object. In this example, at
each iteration, the hash insert starting character of each string
as the key with the string as the associated value. Hence, 
each_with_object returns
=> { 'a' => 'ant', 'bear' => 'bear', 'c' => 'cat' }

Note that the keys are characters, not symbols.


Given answer:
# => { "a" => "ant", "b" => "bear", "c" => "cat" }

Based on our knowledge of each, it might be reasonable to think that
each_with_object returns the original collection. That isn't the case,
though. When we invoke each_with_object, we pass in an object ({} here)
as an argument. That object is then passed into the block and its updated
value is returned at the end of each iteration. Once each_with_object
has iterated over the calling collection, it returns the initially given
object, which now contains all of the updates.

In this code, we start with the hash object, {}. On the first iteration,
we add "a" => "ant" to the hash. On the second, we add "b" => "bear", and
on the last iteration, we add "c" => "cat". Thus, #each_with_object in
this example returns a hash with those 3 elements.

=end


=begin
Practice Problem 5

What does shift do in the following code? How can we find out?

hash = { a: 'ant', b: 'bear' }
hash.shift

My answer:
Array#shift destructively removes and return the first element 
in an array. Since hashes are also commonly represented as nested
arrays, with each element representing a two element array
containing [key, value], and since Ruby 1.9, hash maintains the order
of hash elements according to insertion, it should return
=> [:a, 'ant'], with hash retaining the value { :b => 'bear' }

https://docs.ruby-lang.org/en/2.6.0/Hash.html#method-i-shift
" Removes a key-value pair from hsh and returns it as the 
  two-item array [ key, value ], or the hash's default value
  if the hash is empty." 
  
My intuition is only right for non-empty hash.
For empty hash with default value, only that value is returned,
not an array. For empty hash without default value, nil is 
returned.



Given answer:


shift destructively removes the first key-value pair in hash
and returns it as a two-item array. If we didn't already know
how shift worked, we could easily learn by checking the docs
for Hash#shift. The description for this method confirms our
understanding:

    Removes a key-value pair from hsh and returns it as the 
    two-item array [ key, value ], or the hash’s default value
    if the hash is empty.

There are quite a few Ruby methods, and you're not expected
to know them all. That's why knowing how to read the Ruby
documentation is so important. If you don't know how a method
works you can always check the docs.

=end
puts "Hash with items"
hash = { a: 'ant', b: 'bear' }
p hash
puts "Applying Hash#shift on hash ..."
p hash.shift
p hash
puts

# Empty hash without default value
puts "Null hash without default value"
hash = { }
p hash
puts "Applying Hash#shift on hash ..."
p hash.shift
p hash
puts

# Empty hash with default value
puts "Null hash with default value of 5"
hash = Hash.new(5)
p hash
puts "Applying Hash#shift on hash ..."
p hash.shift
p hash
puts


=begin
Practice Problem 6

What is the return value of the following statement? Why?

['ant', 'bear', 'caterpillar'].pop.size

My answer:
Array#pop destructively removes and returns the last element
in the array. Hence ['ant', 'bear', 'caterpillar'].pop returns
'caterpillar' which is then chained with the size method, to
return the length of the string, i.e. # of characters.
=> 11


Given answer:
# => 11

There are a couple things going on here. First, pop is being
called on the array. pop destructively removes the last element
from the calling array and returns it. Second, size is being
called on the return value by pop. Once we realize that size
is evaluating the return value of pop (which is "caterpillar")
then the final return value of 11 should make sense.

=end


=begin
Practice Problem 7

What is the block's return value in the following code?
How is it determined? Also, what is the return value of
any? in this code and what does it output?

[1, 2, 3].any? do |num|
  puts num
  num.odd?
end

My answer:
A block returns the last evaluated expression of that block.
In this example, the last expression is num.odd? which returns
true if the number is odd and false otherwise. Array#any? returns
true as along as there is 1 truthy (careful, its truthy and not true)
return from the block iterations.

Given answer:


The return value of the block is determined by the return value
of the last expression within the block. In this case the last
statement evaluated is num.odd?, which returns a boolean.
Therefore the block's return value will be a boolean, since
Integer#odd? can only return true or false.

Since the Array#any? method returns true if the block ever returns
a value other than false or nil, and the block returns true on the
first iteration, we know that any? will return true. What is also
interesting here is any? stops iterating after this point since
there is no need to evaluate the remaining items in the array;
therefore, puts num is only ever invoked for the first item in
the array: 1.

TO REVIEW: any? also exhibits short circuiting behavior and stops
iteration once any true value is returned.

=end


=begin
Practice Problem 8

How does take work? Is it destructive? How can we find out?

arr = [1, 2, 3, 4, 5]
arr.take(2)

My answer:
https://docs.ruby-lang.org/en/2.6.0/Array.html#method-i-take
" Returns first n elements from the array in a new array.
  If a negative number is given, raises an ArgumentError."
  
It is not destructive and returns the First n element in the array.


Given answer:
If you're unsure of how a method works the best thing to do is 
to read its documentation. Along with that, testing the method
in irb can be very helpful. In this case we can quickly check
if take is destructive or not by running the code in irb.

irb :001 > arr = [1, 2, 3, 4, 5]
irb :002 > arr.take(2)
=> [1, 2]
irb :003 > arr
=> [1, 2, 3, 4, 5]

By reading the docs and testing the method in irb, we're able
to determine that Array#take selects a specified number of
elements from an array. We're also able to verify that it isn't
a destructive method.

=end


=begin
Practice Problem 9

What is the return value of map in the following code? Why?

{ a: 'ant', b: 'bear' }.map do |key, value|
  if value.size > 3
    value
  end
end

My answer:
Enumerable#map returns a new array containing the return value
of the block on EACH ITEM of the calling collection. In this 
example, the first value 'ant', the conditional is false and 
will return nil. The conditional for 'bear' is true and block
will return 'bear'
=> [nil, 'bear']

# => [nil, "bear"]

There are some interesting things to point out here. First,
the return value of map is an array, which is the collection
type that map always returns. Second, where did that nil come
from? If we look at the if condition (value.size > 3), we'll
notice that it evaluates as true when the length of value
is greater than 3. In this case, the only value with a length
greater than 3 is 'bear'. This means that for the first element,
'ant', the condition evaluates as false and value isn't returned.

When none of the conditions in an if statement evaluates as true,
the if statement itself returns nil. That's why we see nil as the
first element in the returned array.

TO REVIEW:
- map returns a new array regardless whether caller is an array or hash
- map will return the same number of items as the caller, not only those
that evaluates true
- if returns nil even when the conditional is false and no value is returned.

=end


=begin
Practice Problem 10

What is the return value of the following code? Why?

[1, 2, 3].map do |num|
  if num > 1
    puts num
  else
    num
  end
end

My answer:
[1, nil, nil ]
map returns a new array with the transformed values returned by each
iteration of the block. If the number is > 1, the return value of 
puts num, which is nil, is returned by the block. If number is <= 1,
the num itself is returned by the block.


Given answer:
We can determine the block's return value by looking at the return
value of the last statement evaluated within the block. In this case
it's a bit tricky because of the if statement. For the first element,
the if condition evaluates as false, which means num is the block's
return value for that iteration. For the rest of the elements in the
array, num > 1 evaluates as true, which means puts num is the last
statement evaluated, which in turn, means that the block's return
value is nil for those iterations.

Therefore, the return value of map is:

# => [1, nil, nil]
=end