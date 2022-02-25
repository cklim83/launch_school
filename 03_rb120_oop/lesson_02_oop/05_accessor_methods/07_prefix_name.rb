=begin
Using the following code, add the appropriate accessor methods
so that @name is returned with the added prefix 'Mr.'.

class Person
end

person1 = Person.new
person1.name = 'James'
puts person1.name

Expected output:

Mr. James
=end

class Person
  attr_writer :name
  
  def name
    "Mr. #{@name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name


=begin
Solution

class Person
  attr_writer :name

  def name
    "Mr. #{@name}"
  end
end

person1 = Person.new
person1.name = 'James'
puts person1.name

Discussion

In the previous exercise, we formatted the data upon assignment. 
In this example, if we prefixed @name upon assignment, the value
would be modified, which may not be what we want. The goal is to
return the value of @name, but with a prefix.

To accomplish this, we need to manually implement the getter
method. As mentioned in the last exercise, we can't use the built
in accessor methods because we need extra functionality. Therefore,
to return the prefixed @name, we simply need to add the desired
prefix, and add @name through string interpolation.


CONCEPT
- We need to manually implement a setter or getter method if 
  we need customize from the plain vanilla version provided
  by ruby built-in attr_reader, attr_writer or attr_accessor 
  methods
=end