=begin
Using the following code, add an instance method named compare_secret
that compares the value of @secret from person1 with the value of
@secret from person2.

class Person
  attr_writer :secret

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)

Expected output:

false
=end

class Person
  attr_writer :secret

  def compare_secret(another_person)
    self.secret == another_person.secret
  end
  
  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)


=begin
Solution

class Person
  attr_writer :secret

  def compare_secret(other_person)
    secret == other_person.secret
  end

  protected

  attr_reader :secret
end

person1 = Person.new
person1.secret = 'Shh.. this is a secret!'

person2 = Person.new
person2.secret = 'Shh.. this is a different secret!'

puts person1.compare_secret(person2)

Discussion

Protected methods are very similar to private methods. 
The main difference between them is protected methods allow access
between class instances, while private methods don't. 
If a method is protected, it can't be invoked from outside the class.
This allows for controlled access, but wider access between class instances.

In the solution, we pass person2 as an argument into #compare_secret. 
We then compare the value of @secret from person1 with the value of
@secret from person2. We do this using the == operator which returns a boolean.


CONCEPTS
- Protected method can be accessed by another object of the same class
  inside the class definition while private methods cannot

- Both protected and private methods cannot be accessed outside class definition

- We can call getter inside instance method without self, no confusion with 
  local variable unlike setter

=end