=begin
How do we create an object in Ruby? Give an example of the creation of an
object.
=end

Class MyClass
end

my_object = MyClass.new

=begin
Solution

We create an object by defining a class and instantiating it by using the
.new method to create an instance, also known as an object.

class MyClass
end

my_obj = MyClass.new

My Review
- Should be class and not Class in class definition
=end


=begin
What is a module? What is its purpose? How do we use them with our classes?
Create a module for the class you created in exercise 1 and include it
properly.
=end

=begin
My answer:
A module is a collection of reusable code that can be made up of methods, 
classes etc. We can use a module in our class using the `include` method 
call
=end


module MyModule
  def print_module_name
    puts "inside_my_module"
  end
end

class MyClass
  include MyModule
end

my_object = MyClass.new
my_object.print_module_name


=begin
Solution

A module allows us to group reusable code into one place. We use modules in
our classes by using the include method invocation, followed by the module
name. Modules are also used as a namespace.

module Study
end

class MyClass
  include Study
end

my_obj = MyClass.new
=end