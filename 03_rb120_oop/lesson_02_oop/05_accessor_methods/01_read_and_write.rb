=begin
Add the appropriate accessor methods to the following code.

class Person
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

Expected output:

Jessica
=end

class Person
  attr_accessor :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name


=begin
Solution

class Person
  attr_writer :name
  attr_reader :name
end

person1 = Person.new
person1.name = 'Jessica'
puts person1.name

Discussion

To access an object's instance variables from outside the object, 
we need to invoke an accessor method. In the initial example, after
the instantiation of person1, we invoke a method named name=. Due
to Ruby's syntactical sugar, the method invocation looks like this:

person1.name = 'Jessica'

Without Ruby's syntactical sugar, it looks like this:

person1.name=('Jessica')

We can manually implement #name= inside the Person class, like so:

class Person
  def name=(value)
    @name = value
  end
end

However, using accessor methods is so common in Ruby that there's a
built in way to quickly create them.

class Person
  attr_writer :name
end

#attr_writer is a simpler way of implementing #name=. This not only
applies to setter methods, like #name=, but to getter methods as well
by using #attr_reader.

You can also use #attr_accessor instead of specifying both #attr_reader
and #attr_writer. This is examined in more detail in the next exercise.


CONCEPTS
- obj.attribute = value is syntatic sugar for obj.attribute=(value) method 
  call, i.e. setter method call.
- attr_writer, attr_reader are shortcut methods built-in Ruby to save time
  from manually creating setter and getter methods. These methods will have
  attribute_name and attribute_name= as function names
- We can use attr_assessor :attribute_name if we need both getter and setter
=end