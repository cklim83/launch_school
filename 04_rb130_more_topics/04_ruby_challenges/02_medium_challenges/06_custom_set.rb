# rubocop:disable all

=begin

Custom Set

Create a custom set type.

Sometimes it is necessary to define a custom data structure of some type, like
a set. In this exercise you will define your own set type. How it works
internally doesn't matter, as long as it behaves like a set of unique elements
that can be manipulated in several well defined ways.

In some languages, including Ruby and JavaScript, there is a built-in Set type.
For this problem, you're expected to implement your own custom set type. Once
you've reached a solution, feel free to play around with using the built-in
implementation of Set.

For simplicity, you may assume that all elements of a set must be numbers.
=end

=begin
Problem
- Implement a CustomSet class where items add to a Set object are all
  distinct and unique. 
- What about the order of the elements? 

Examples and Test Cases
- We need to define a CustomSet class
- constructor with optional arguments
  - optional argument can be an array
- instance method: empty? 
  - returns a boolean dependent where the set object contains any items
- instance method: contains?(item)
  - returns a boolean based on whether the set object contain that item.
- instance method: subset?(other_set)
  - returns a boolean depending on whether caller set is a subset of other_set.
    A set is a subset if all its contents are included in the other set.
    Note: An empty set is an universal subset, even if other_set is also empty.
- instance method: disjoint?(other_set)
  - returns a boolean depending on whether caller set and other_set are
    disjoint. Two sets are disjoint if they do not have common elements.
    Empty sets are universal disjoint set, even if other_set is also empty.
- instance method: eql?(other_set)
  - returns a boolean depending on whether caller set is equal to other_set.
    Two sets are equal if they contain the same distinct elements, even if
    they are instantiated with differing arrays e.g. [1,2,3,1] vs [ 2,2,1,3]
    If both sets are empty, they are also equal.
- instance method: add(int)
  - append an element to the set, mutates the caller.
- instance method: intersection(other_set)
  - returns a new set with elements common to both sets. If both sets
    have no common elements, return an empty set. If either caller or other_set
    or both are empty, return an empty set. The order of the common elements
    used in instantiation does not matter.
- instance method: difference(other_set)
  - returns a new set containing the difference between caller and other_set
    Result is equivalent to distinct elements in caller  - distinct elements
    in other_set
- instance method: union(other_set)
  - returns a new set containing the union of the two sets (no duplicates)

Data Structures
- We may want to use an array to hold the elements in the set. Assuming we are
  not supposed to use Set class since that is what we are trying to mimic.
- Array#uniq will be useful to ignore duplicates
- Array#sort could also be useful so that the order of inclusion does not
  matter
- Array#include? will also be useful for comparison

Algorithm
- Constructor([array])
  - We can have an argument with default value of []
  - assign @elements = unique and sorted elements of array
  
- #empty?
  - return @elements.empty?

- #contains?(item)
  - return @elements.include?(item)
  
- #subset?(other_set)
  - return true if all elements of own set is contained in other_set
  
- #disjoint?(other_set)
  - return true if all elements of own set is not contained in other_set
  
- #eql?(other_set)
  - return true if all elements of own set is equal to elements of other_set

- #add(item)
  - append item into own set if item is not in own set, mutates caller
  
- #intersection(other_set)
  - return a new custom set object containing the common items in both sets.
    If both sets are disjoint (i.e. no common elements), return empty custom set

- #difference(other_set)
  - return a new custom set object containing elements in self not present in 
    other_set

- #union(other_set)
  - return a new custom set object containing the unique elements of both
    self and others
=end
  
# rubocop:enable all

class CustomSet
  attr_reader :elements

  def initialize(array = [])
    @elements = array.uniq.sort
  end

  def empty?
    elements.empty?
  end

  def contains?(item)
    elements.include?(item)
  end

  def subset?(other_set)
    elements.all? { |element| other_set.contains?(element) }
  end

  def disjoint?(other_set)
    elements.all? { |element| !other_set.contains?(element) }
  end

  def size
    elements.size
  end

  def eql?(other_set)
    elements.size == other_set.size && subset?(other_set)
  end
  alias == eql?

  def add(item)
    unless elements.include?(item)
      elements << item
      elements.sort!
    end
    self
  end

  def intersection(other_set)
    common_set = CustomSet.new
    elements.each do |element|
      common_set.add(element) if other_set.contains?(element)
    end
    common_set
  end

  def difference(other_set)
    difference_set = CustomSet.new
    elements.each do |element|
      difference_set.add(element) unless other_set.contains?(element)
    end
    difference_set
  end

  def union(other_set)
    union_set = clone
    other_set.elements.each do |element|
      union_set.add(element)
    end
    union_set
  end
end

# rubocop:disable all
=begin
PEDAC Solution


Understanding the Problem
  For our program, the details we need to keep in mind are as follows:

    A set only allows for unique values.
    Values in a set can be stored in any order.
    All values must be numbers.

  The problem description doesn't give us much detail about how our custom
  set should behave. We can look at the test cases for more information.


Examples and Test Cases
  The test cases indicate that we need to write several instance methods for
  a class, CustomSet. We should be able to add elements to a set using the
  instance method add.

  There are also some important terms to note:

    A set, A, is a subset of another set, B, if all of the elements in A are
    also in set B.
        { 1, 2, 3 } is a subset of { 2, 4, 3, 1 }
        { 1, 2, 3 } is not a subset of { 1, 2 }
        { 1, 2, 3 } is not a subset of { 1, 2, 4, 5 }

    Two sets, A and B, are said to be disjoint if none of the elements in
    set A are in set B. That also implies that none of the elements in B
    are in A.
        { 1, 2, 3 } and { 4, 5, 6 } are disjoint sets.
        { 1, 2, 3 } and { 4, 3, 6 } are not disjoint

    Two sets are said to be equal if both sets contain the exact same elements.
        { 1, 2, 3 } and { 1, 2, 3 } are equal sets.
        { 1, 2, 3 } and { 3, 1, 2 } are also equal sets - the order does not matter.
        { 1, 2, 3 } and { 1, 2 } are not equal sets.

    The intersection of two sets, A and B, is a new set that contains all of
    the elements that are in both A and B. That is, the intersection contains
    all of the shared elements.
        The intersection of { 1, 2, 3 } and { 1, 3, 5 } is { 1, 3 }.
        The intersection of { 1, 2, 3 } and { 4, 5, 6 } is the empty set: { }.

    The union of two sets, A and B, is a new set that contains all of the
    elements that are in either A and B (and perhaps both).
        The union of { 1, 2, 3 } and { 1, 3, 5 } is { 1, 2, 3, 4, 5 }.

    The difference of two sets, A and B, is a new set that contains all of the
    elements of A that are not present in B.
        The difference of { 1, 2, 3 } and { 1, 3, 5 } is { 2 }.
        The difference of { 1, 5, 7 } and { 1, 2, 3 } is { 5, 7 }.
        The difference of { 1, 2, 3 } and { 4, 5, 6 } is { 1, 2, 3 }.

  The methods we need for our CustomSet revolve around the above terms:

    a constructor method.
    a method to return the intersection of the current set with another.
    a method to return the union of the current set with another.
    a method to return the difference between the current set and another.
    a method that determines whether the current set and another are disjoint.
    a method that determines whether the current set and another are equal.
    a method that determines whether the current set is a subset of another.
    a method that adds a new element to the current set.
    a method that determines whether the current set contains a specific value.
    a method that determines whether the current set is empty.

  We may also want to create some helper methods to assist us, but those are
  optional.


Data Structures
  There are two major data structures we might want to consider for our
  custom sets -- arrays and dictionaries.

  It's possible that you've never heard of the term dictionary when talking
  about structures. That's okay - the term is just a generic way of referring
  to something that you're already familiar with, but by a different name.
  Depending on the languages you're familiar with, they are known as hashes,
  associative arrays, mappings, or just ordinary objects. For instance:

    In Ruby, hashes play the role of dictionaries.
    In JavaScript, plain objects play the role of dictionaries.

  In short, a dictionary is a data structure that allows values to be stored
  and retrieved as key/value pairs. It's a lot like an English language
  dictionary: the words listed are keys, and the definitions are values.

  For most set types, dictionaries seem like a good choice at first glance.
  You just create a dictionary that uses the element values as keys and the
  value associated with each pair can be anything (usually something like nil,
  null, or 0). This works great in languages like Ruby where a hash key can
  be any value, but it fails in JavaScript where object keys are always
  treated as strings. In this program, dictionaries are acceptable, even
  in JavaScript -- the number values will be coerced to strings.

  Arrays are also a good choice, though the implementation of an array-based
  set is a little more complex. In particular, you have to search the array
  sequentially every time you want to determine whether the set contains a
  specific element. With large sets, that sequential search can also result
  in performance issues. Despite the complexity and performance issues, we
  will use an array in our solutions. (Later, if you want, you can rework
  your solution to use a dictionary.)


Hints and Questions
  Sets don't have to be in any particular order.

  The constructor takes an array as an argument, and uses the contents of
  that argument as the elements of the set. If the array contains duplicate
  values, only one instance of the value should be stored in the set.


Algorithm
    constructor
        - If the argument was omitted, default to an empty array.
        - Initialize the instance's internal array to the unique elements from
          the argument array.

    Method: is this set empty? (Ruby: empty?; JavaScript: isEmpty)
        - Return true if the internal array's length is 0.
        - Return false otherwise.

    Method: intersection
        - Find all elements from this set that are also present in the other
          set.
        - Use the found elements to create a new set
        - Return the new set.

    Method: union
        - Create a duplicate set from the current set to use as the result.
        - Add all of the elements from the other set to the result set
        - Return the result set.

    Method: difference
        - Find all elements from this set that are not present in the set
          passed as an argument.
        - Use the found elements to create a new set
        - Return the new set.

    Method: are sets disjoint? (Ruby: disjoint?; JavaScript: isDisjoint)
        - Are any of the elements in the current set present in the other set?
            Yes: return false
            No: return true

    Method: are sets identical? (Ruby: eql?; JavaScript: isSame)
        - Return false if the two sets have different sizes
        - Are any of the elements in the current set missing in the other set?
            Yes: return false
            No: return true

    Method: is subset? (Ruby: subset?; JavaScript: isSubset)
        - Are all of the elements in the current set present in the other set?
            Yes: return true
            No: return false

    Method: add
        - Is element currently in set array?
            No. Push the element onto the set array.
        Return current set.

    Method: is element in set? (Ruby: contains?; JavaScript: contains)
        - Does set array contains element?
            Yes. Return true.
            No. Return false.


Algorithm (Ruby)
    Method: ==
        Call eql? method.


Ruby Solution and Discussion

class CustomSet
  def initialize(set = [])
    @elements = set.uniq
  end

  def empty?
    elements.empty?
  end

  def intersection(other_set)
    same_elements = elements.select { |el| other_set.contains?(el) }
    CustomSet.new(same_elements)
  end

  def union(other_set)
    union_set = CustomSet.new(elements)
    other_set.elements.each { |el| union_set.add(el) }
    union_set
  end

  def difference(other_set)
    different_elements = elements.select { |el| !other_set.contains?(el) }
    CustomSet.new(different_elements)
  end

  def disjoint?(other_set)
    elements.none? { |el| other_set.contains?(el) }
  end

  def eql?(other_set)
    return false unless elements.length == other_set.elements.length
    elements.all? { |el| other_set.contains?(el) }
  end

  def subset?(other_set)
    elements.all? { |el| other_set.contains?(el) }
  end

  def add(element)
    elements.push(element) unless contains?(element)
    self
  end

  def contains?(element)
    elements.include?(element)
  end

  def ==(other_set)
    eql?(other_set)
  end

  protected

  attr_accessor :elements
end


We needed to write several instance methods here, but we were able to use the
built-in array methods to do a lot of work for us because we chose to store
our set elements in an array within our initializer method.

#intersection and #difference leveraged Array#select to create a new set based
on whether or not the argument set already contained elements from the current
set.

In the #union method, we create a new CustomSet instance that contains all
elements of both the calling set and the argument set. Note that we use the
#add method here within #union which guards against any duplicates being
added to the new set.

#subset? and #disjoint? require all elements of the calling set to meet
certain criteria and must return a boolean -- the Array#all? and Array#none?
methods came in handy here. They return a boolean based on whether the block
returns a truthy value for all or none of the elements of the array.

One important note about our #add method is that it only adds a new element
to a set if the set does not already contain that value. This preserves the
uniqueness of our set's elements.

Two CustomSet objects are said to be equal if they are the same length and
are a subset of one another. We leverage this in our #eql? method, which
first compares the length of the two sets. If the lengths are the same, we
return the result of invoking #subset.
=end


=begin
CONCEPTS (IMPORTANT)
- assert_equal rely on CustomClass#== to compare two custom class correctly

- alias_method :alternate_method_name, :method_name

- Take note the return value and whether the method mutates the caller or
  creates a new instance. For example with add, we are supposed to return
  the original object so self should the last statement in the method. Likewise,
  methods like intersecution etc are query in nature and should not mutate the
  caller.

- We need to have access to the internal elements of a set e.g. for union
  when we one to add elements of both set. However we should guard against
  access outside the class that may compromise the integrity of the data. 
  Hence private method for elements is most appropriate, as used in the 
  given solution, is most appropriate.
=end
