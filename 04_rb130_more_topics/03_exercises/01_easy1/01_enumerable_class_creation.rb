=begin

Enumerable Class Creation

Assume we have a Tree class that implements a binary tree.

class Tree
  ...
end

A binary tree is just one of many forms of collections, such as Arrays,
Hashes, Stacks, Sets, and more. All of these collection classes include
the Enumerable module, which means they have access to an each method,
as well as many other iterative methods such as map, reduce, select,
and more.

For this exercise, modify the Tree class to support the methods of
Enumerable. You do not have to actually implement any methods
-- just show the methods that you must provide.
=end

=begin
From documentation, to use Enumerable methods in a custom class, we need to
1) include Enumerable
2) implement each method for the custom collection class
# https://docs.ruby-lang.org/en/master/Enumerable.html#module-Enumerable-label-Usage
=end

class Tree
  include Enumerable
  
  def each
  end
end


=begin
Solution

class Tree
  include Enumerable

  def each
    ...
  end
end

Discussion

To provide most of the functionality of the Enumerable module, all you need to
do is include Enumerable in your class, and define an each method that yields
each member of the collection, one at a time.
=end


=begin
CONCEPTS
- To allow a custom collection class to use Enumerable method, we need to 
  include the Enumerable module and then implement each method that iterates
  through each element of the collection as almost all Enumerable method 
  will make use of this each method.
=end

