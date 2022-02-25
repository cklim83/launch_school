=begin
Using the following code, determine the lookup path used when invoking cat1.color.
Only list the classes and modules that Ruby will check when searching for the #color method.

class Animal
end

class Cat < Animal
end

class Bird < Animal
end

cat1 = Cat.new
cat1.color

=end

=begin
My answer:
Cat -> Animal -> Object -> Kernel -> BasicObject
Ruby will look up all the way since #color was not implemented
in Cat and Animal and also not found in Object, Kernel and BasicObject.
All created classes inherit from Object which in turn mixin the
Kernel module and also inherit from BasicObject.
=end


=begin
Solution

Cat
Animal
Object
Kernel
BasicObject

Discussion

Nearly every class in Ruby inherits from another class. This is true
until the class named BasicObject, which doesn't inherit from a class.
Some classes also include modules, much as the Object class includes
the Kernel module.

Here, Ruby searches for the #color method in every class and module in
the search path. Since the method isn't anywhere, the answer includes
every class and module in the search path.


CONCEPTS
- All classes inherits from Object class
- Object class inherits from BasicObject (the only class who doesn't
  inherit from another class) and mixin Kernel module
- The maximum that Ruby will look up a method is till BasicObject
  since it doesnt inherit from any other class
=end
