=begin
Using the following code, add the appropriate accessor methods
so that @name is capitalized upon assignment.

class Person
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name

Expected output:

Elizabeth
=end

class Person
  attr_reader :name
  
  def name=(other_name)
    @name = other_name.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name


=begin
Solution

class Person
  attr_reader :name

  def name=(name)
    @name = name.capitalize
  end
end

person1 = Person.new
person1.name = 'eLiZaBeTh'
puts person1.name

Discussion

When handling data, sometimes it makes sense to format, or even validate,
the data immediately. For instance, in the initial example, we're given
the string 'eLiZaBeTh' and asked to format it while assigning it to the
instance variable @name. This isn't an unrealistic request, due to the
fact that first names are typically capitalized.

To accomplish this, we need to manually write the setter method. Normally,
we would use Ruby's built in accessor methods, but since we have to add
extra functionality to the method, we're forced to implement our own.

class Person
  def name=(name)
    @name = name
  end
end

To capitalize @name upon assignment, all we need to do is invoke #capitalize
on name. Using this approach guarantees that each person's name will always
be formatted correctly.


CONCEPT
- We need to manually implement a setter or getter method if 
  we need customize from the plain vanilla version provided
  by ruby built-in attr_reader, attr_writer or attr_accessor 
  methods
=end
