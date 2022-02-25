=begin
1. Given this class:

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

One problem is that we need to keep track of different breeds of dogs,
since they have slightly different behaviors. For example, bulldogs
can't swim, but all other dogs can.

Create a sub-class from Dog called Bulldog overriding the swim method
to return "can't swim!"
=end

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class BullDog < Dog
  def swim
    "can't swim"
  end
end

cutey = BullDog.new
puts cutey.speak
puts cutey.swim

=begin
class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

karl = Bulldog.new
puts karl.speak           # => "bark!"
puts karl.swim            # => "can't swim!"

Note that since Bulldog objects are sub-classes of Dog objects,
they can both override and inherit methods. That is why karl can speak.
=end


=begin
2. Let's create a few more methods for our Dog class.

class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end

  def fetch
    'fetching!'
  end
end

Create a new class called Cat, which can do everything a dog can,
except swim or fetch. Assume the methods do the exact same thing.
Hint: don't just copy and paste all methods in Dog into Cat; 
try to come up with some class hierarchy.
=end

class Pet
  def speak
    'bark!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def swim
    'swimming!'
  end
  
  def fetch
    'fetching!'
  end
end

class BullDog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    'Meeoow!'
  end
end

=begin
We could just duplicate the methods in the Cat class.
But that wouldn't be DRY, and this is exactly why we OOP
-- to allow us to organize behaviors into classes, and
set up a hierarchical structure that takes advantage of
inheritance. Inheriting behaviors is a way to re-use
common behaviors.

class Pet
  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def speak
    'bark!'
  end

  def fetch
    'fetching!'
  end

  def swim
    'swimming!'
  end
end

class Cat < Pet
  def speak
    'meow!'
  end
end

It's getting slightly more complicated, but we've shuffled
the methods (behaviors) around a bit into their appropriate
classes. All pets (that we know of so far) can run and jump,
so those two methods are in the Pet class. On top of those
two behaviors, dogs can further fetch and swim, so those two
methods are added to the Dog class. Cats don't have any
additional behaviors (we'll talk about speak below).

Both dogs and cats can speak, so why not have that behavior
in the Pet class? The reason is because we do not have a good
default for speak for all pets, so we don't want to jump to
conclusions and allow specific pets (ie, the sub-classes) to
implement that method.

Let's make sure everything works as expected.

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

pete.run                # => "running!"
pete.speak              # => NoMethodError

kitty.run               # => "running!"
kitty.speak             # => "meow!"
kitty.fetch             # => NoMethodError

dave.speak              # => "bark!"

bud.run                 # => "running!"
bud.swim                # => "can't swim!"
=end


=begin
4. What is the method lookup path and how is it important?
=end

puts BullDog.ancestors
puts Dog.ancestors
puts Cat.ancestors
puts Pet.ancestors 

=begin
My answer:
Lookup Path for BullDog
- BullDog
- Dog
- Pet
- Object
- Kernel
- Basic Object

Lookup Path for Cat
- Cat
- Pet
- Object
- Kernel
- Basic Object

Lookup Path for Dog
- Dog
- Pet
- Object
- Kernel
- Basic Object

Lookup Path for Pet
- Pet
- Object
- Kernel
- Basic Object

The method lookup path determines the order where Ruby will use
to search for a method of a certain class. If an invoked method
is present in a few classes, the earliest one on the lookup path
will be executed. 
=end


=begin
The method lookup path is the order in which Ruby will traverse the
class hierarchy to look for methods to invoke. For example, say you
have a Bulldog object called bud and you call: bud.swim. Ruby will
first look for a method called swim in the Bulldog class, then
traverse up the chain of super-classes; it will invoke the first
method called swim and stop its traversal.

In our simple class hierarchy, it's pretty straight forward. Things
can quickly get complicated in larger libraries or frameworks. To
see the method lookup path, we can use the .ancestors class method.

Bulldog.ancestors       # => [Bulldog, Dog, Pet, Object, Kernel, BasicObject]

Note that this method returns an array, and that all classes sub-class
from Object. Don't worry about Kernel or BasicObject for now.
=end