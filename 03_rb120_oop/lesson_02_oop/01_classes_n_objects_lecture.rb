=begin
Given the below usage of the Person class, code the class definition.

bob = Person.new('bob')
bob.name                  # => 'bob'
bob.name = 'Robert'
bob.name                  # => 'Robert'
=end

class Person
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
end

=begin
Solution:

A nice, simple class with one getter/setter.

class Person
  attr_accessor :name

  def initialize(n)
    @name = n
  end
end
=end


=begin
Modify the class definition from above to facilitate the following methods.
Note that there is no name= setter method now.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

Hint: let first_name and last_name be "states" and create an instance method
called name that uses those states.
=end

# class Person
#   attr_reader :first_name
#   attr_accessor :last_name
  
#   def initialize(first_name, last_name="")
#     @first_name = first_name
#     @last_name = last_name
#   end
  
#   def name
#     (first_name + ' ' + last_name).strip
#   end
# end

# bob = Person.new('Robert')
# p bob.name                  # => 'Robert'
# p bob.first_name            # => 'Robert'
# p bob.last_name             # => ''
# bob.last_name = 'Smith'
# p bob.name                  # => 'Robert Smith'


=begin
Solution:

This class has two getter/setter pairs, and a r
egular instance method called name.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end
=end


=begin
Now create a smart name= method that can take just a first name
or a full name, and knows how to set the first_name and last_name
appropriately.

bob = Person.new('Robert')
bob.name                  # => 'Robert'
bob.first_name            # => 'Robert'
bob.last_name             # => ''
bob.last_name = 'Smith'
bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
bob.first_name            # => 'John'
bob.last_name             # => 'Adams'
=end

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    set_name(name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(new_name)
    set_name(new_name)
  end
  
  private
  
  def set_name(name)
    names = name.split
    self.first_name = names.first
    self.last_name = names.size > 1 ? names.last : ''
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

=begin
Solution:

We actually already did this in the initialize method, so we can just
repeat it for the name= method. Note that Ruby gives us a special syntax
for methods that end in =, so the name= method can be used like this:
bob.name = 'Robert Smith', rather than the more awkward
bob.name=('Robert Smith').

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

Note the redundant code in the initialize and the name= methods.
Let's move that to another method to DRY up the code. Our new
method can be private, since it's not being used outside of the
class definition.

class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end
=end


=begin
Using the class definition from step #3, let's create a few more
people -- that is, Person objects.

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

If we're trying to determine whether the two objects contain the
same name, how can we compare the two objects?
=end

class Person
  attr_accessor :first_name, :last_name
  
  def initialize(name)
    set_name(name)
  end
  
  def name
    "#{first_name} #{last_name}".strip
  end
  
  def name=(new_name)
    set_name(new_name)
  end
  
  def same_name?(other_person)
    self.name == other_person.name
  end
  
  private
  
  def set_name(name)
    names = name.split
    self.first_name = names.first
    self.last_name = names.size > 1 ? names.last : ''
  end
end

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')
p bob.same_name?(rob)


=begin
We would not be able to do bob == rob because that compares
whether the two Person objects are the same, and right now
there's no way to do that. We have to be more precise and
compare strings:

bob.name == rob.name

The above code compares a string with a string. But aren't
strings also just objects of String class? If we can't compare
two Person objects with each other with ==, why can we compare
two different String objects with ==?

str1 = 'hello world'
str2 = 'hello world'

str1 == str2          # => true

What about arrays, hashes, integers? It seems like Ruby treats
some core library objects differently. For now, memorize this
behavior. We'll explain the underpinning reason in a future lesson.
=end


=begin
Continuing with our Person class definition, what does the below
print out?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
=end

=begin
My answer: it will print out the class of Bob i.e. Person and its
encoded object_id using the to_s method from superclass object
=end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"

=begin
Solution:

The person's name is: #<Person:0x007fb873252640>

This is because when we use string interpolation (as opposed to string
concatenation), Ruby automatically calls the to_s instance method on
the expression between the #{}. Every object in Ruby comes with a to_s
inherited from the Object class. By default, it prints out some gibberish,
which represents its place in memory.

If we do not have a to_s method that we can use, we must construct the
string in some other way. For instance, we can use:

puts "The person's name is: " + bob.name        # => The person's name is: Robert Smith

or

puts "The person's name is: #{bob.name}"        # => The person's name is: Robert
=end


=begin
Let's add a to_s method to the class:

class Person
  # ... rest of class omitted for brevity

  def to_s
    name
  end
end

Now, what does the below output?

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
=end

=begin
My answer:
It will ouput the following:
"The person's name is: Robert Smith"
=end

=begin
Solution:
This time it works as expected, due to the to_s method!

The person's name is: Robert Smith
=end