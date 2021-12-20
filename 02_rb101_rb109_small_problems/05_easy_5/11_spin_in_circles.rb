=begin

Spin Me Around In Circles

You are given a method named spin_me that takes a string as an argument
and returns a string that contains the same words, but with each word's
characters reversed. Given the method's implementation, will the returned
string be the same object as the one passed in as an argument or a
different object?

def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

spin_me("hello world") # "olleh dlrow"

=end

=begin

My answer
- str.split will return a new array with elements that are new objects having same values
  as individual words in the original string
- Thus the return string will be a new object than what is passed in as argument

=end


=begin

Solution

The method will return a different object.
Discussion

Your initial hunch might have been that the method will return the same
string object. Since we are using mutating method String#reverse! inside
of the do..end block, and we are also calling each method on the resulting
array, which also returns the original array.

However, as soon as we have converted string into an array by calling split
method on it, it is no longer possible for us to get back the original
object again. Even just doing str.split.join(" ") returns a different object
since you are splitting the string into an array and then joining that array
back into a new string, with the same sequence of characters but still, a
different object.

Let's also break down what happens inside of the spin_me method. str.split
converts the string into array ['hello', 'world']. When we call each method
on this array and reverse each word inside of the array, our original array
gets mutated and now it's values are ['olleh', 'dlrow'].

So we have mutated the array that we got by splitting the string, but, when
we join this array back into a string, a completely new string is returned.

You can check this by calling Object#object_id method.

def spin_me(str)
  str.split.each do |word|
    word.reverse!
  end.join(" ")
end

str = 'hello world'
puts str.object_id # 47435609148580
puts spin_me(str).object_id # 47435609148360

You will get different numbers, but the principle is the same.

However, if we rework this method to use an array argument instead of a string
and we reversed each word in it by calling the same methods, then the array
that was passed in as an argument and the array that was returned from the
method would be the same object. Again, we can test this.

=end

def spin_me(arr)
  arr.each do |word|
    word.reverse!
  end
end

arr = ['hello', 'world']
puts arr.object_id # 10385740
puts arr[0].object_id # 10385780
puts arr[1].object_id # 10385760

puts "after method call"
puts spin_me(arr).object_id # 10385740
puts spin_me(arr)[0].object_id # 10385780
puts spin_me(arr)[1].object_id # 10385760


=begin

TO REVIEW
- Explanation of how split generates a new object
- Even just doing str.split.join(" ") returns a different object
since you are splitting the string into an array and then joining that array
back into a new string, with the same sequence of characters but still, a
different object.
- If the argument is an array however, we will get back the original object

=end

