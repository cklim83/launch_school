=begin

Iterators: True for None?

In the previous two exercises, you developed methods called any? and all? that
are similar to the standard Enumerable methods with the same names. In this
exercise, you will develop another of the methods in this family, none?.

Enumerable#none? processes elements in a collection by passing each element
value to a block that is provided in the method call. If the block returns
true for any element, then #none? returns false. Otherwise, #none? returns
true. Note in particular that #none? will stop searching the collection the
first time the block returns true.

Write a method called none? that behaves similarly for Arrays. It should
take an Array as an argument, and a block. It should return true if the
block returns false for all of the element values. Otherwise, it should
return false.

Your method should stop processing elements of the Array as soon as the
block returns true.

If the Array is empty, none? should return true, regardless of how the
block is defined.

Your method may not use any of the following methods from the Array and
Enumerable classes: all?, any?, none?, one?. You may, however, use either
of the methods created in the previous two exercises.

Examples:

none?([1, 3, 5, 6]) { |value| value.even? } == false
none?([1, 3, 5, 7]) { |value| value.even? } == true
none?([2, 4, 6, 8]) { |value| value.odd? } == true
none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
none?([1, 3, 5, 7]) { |value| true } == false
none?([1, 3, 5, 7]) { |value| false } == true
none?([]) { |value| true } == true

=end

def none?(collection)
  collection.each { |element| return false if yield(element) }
  true
end

p none?([1, 3, 5, 6]) { |value| value.even? } == false
p none?([1, 3, 5, 7]) { |value| value.even? } == true
p none?([2, 4, 6, 8]) { |value| value.odd? } == true
p none?([1, 3, 5, 7]) { |value| value % 5 == 0 } == false
p none?([1, 3, 5, 7]) { |value| true } == false
p none?([1, 3, 5, 7]) { |value| false } == true
p none?([]) { |value| true } == true


=begin
Solution

def none?(collection)
  collection.each { |item| return false if yield(item) }
  true
end

Alternate solution:

def none?(collection, &block)
  !any?(collection, &block)
end

Discussion

The key to this solution is that #none? is merely the opposite of #any?.
#any? returns true if the collection contains any matches, false if does
not. #none? returns true if the collection does not contain any matches,
false if does.

The easiest way to accomplish this is to just modify the #any? method we
wrote earlier; instead of returning true from the #each loop, we return
false; instead of returning false after the loop, we return true.

However, since #none? is effectively the negation of #any?, you would
think that we can write:

def none?(collection)
  !any?(collection)
end

However, this fails with a:

no block given (yield) (LocalJumpError)

error message. The reason for this is that blocks aren't passed down the
calling chain by default. Instead, you need to explicitly pass the block
to #any?; to do that, #none? must require a block argument with an & as
shown in the alternate solution. We then pass &block to any?, where it
is treated as if the call to any? included the block.
=end


=begin
TO REVIEW
- The block passed to #none? is not available to #any? directly. To fix
  this, we need to:
  - Store the block as an explicit block parameter using &block. This will convert
    the block passed into a Proc named block
  - When we call any?, we DO NOT just pass in block as an argument as block is not a 
    Proc object. To convert back to a block for #any? to use, we use &block.
=end
  