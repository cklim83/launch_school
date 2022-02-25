=begin
Question 1

Ben asked Alyssa to code review the following code:

class BankAccount
  attr_reader :balance

  def initialize(starting_balance)
    @balance = starting_balance
  end

  def positive_balance?
    balance >= 0
  end
end

Alyssa glanced over the code quickly and said - "It looks fine, except that you forgot
to put the @ before balance when you refer to the balance instance variable in the body
of the positive_balance? method."

"Not so fast", Ben replied. "What I'm doing here is valid - I'm not missing an @!"

Who is right, Ben or Alyssa, and why?

My answer:
Ben is right. He is calling the getter to retrieve the balance instance variable
rather than the instance variable directly.

Solution
Ben is right because of the fact that he added an attr_reader for the balance instance variable.
This means that Ruby will automatically create a method called balance that returns the value
of the @balance instance variable. The body of the positive_balance? method will evaluate to
calling the balance method of the class, which will return the value of the @balance instance
variable. If Ben had omitted the attr_reader (or had used an attr_writer rather than a reader
or accessor) then Alyssa would be right.


CONCEPTS
- Using getter and setters in instance methods and the need for self prefix
=end


=begin
Question 2

Alan created the following code to keep track of items for a shopping cart application he's writing:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    quantity = updated_count if updated_count >= 0
  end
end

Alyssa looked at the code and spotted a mistake. "This will fail when update_quantity is called", she says.

Can you spot the mistake and how to address it?

My answer:
Original code will not work for two reasons
- attr_writer for quantity is missing and there is no setter created
- we need to prefix a setter with self to distinguish them from local variables

class InvoiceEntry
  attr_reader :quantity, :product_name
  attr_writer :quantity

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    # prevent negative quantities from being set
    self.quantity = updated_count if updated_count >= 0
  end
  
  
Solution

The problem is that since quantity is an instance variable, it must be accessed with the @quantity notation when setting it.
Even though attr_reader is defined for quantity, the fact that it's a reader means that there is implicitly a method for
retrieving the value (a "getter") but the setter is undefined. So there are two possible solutions:

1. change attr_reader to attr_accessor, and then use the "setter" method like this: self.quantity = updated_count if updated_count >= 0. 
OR
2. reference the instance variable directly within the update_quantity method, like this @quantity = updated_count if updated_count >= 0

CONCEPTS
- Attribute getters and setters

end


=begin
Question 3

In the last question Alan showed Alyssa this code which keeps track of items for a shopping cart application:

class InvoiceEntry
  attr_reader :quantity, :product_name

  def initialize(product_name, number_purchased)
    @quantity = number_purchased
    @product_name = product_name
  end

  def update_quantity(updated_count)
    quantity = updated_count if updated_count >= 0
  end
end

Alyssa noticed that this will fail when update_quantity is called. Since quantity is an instance variable,
it must be accessed with the @quantity notation when setting it. One way to fix this is to change attr_reader
to attr_accessor and change quantity to self.quantity.

Is there anything wrong with fixing it this way?

My answer:
This proposed solution will fix the update_quantity method. However, changing the attr_reader to attr_accessor
will indirectly also create a setter for product_name instance variable which may be an unwanted side effect


Solution
Nothing incorrect syntactically. However, you are altering the public interfaces of the class. In other words,
you are now allowing clients of the class to change the quantity directly (calling the accessor with the
instance.quantity = <new value> notation) rather than by going through the update_quantity method. It means
that the protections built into the update_quantity method can be circumvented and potentially pose problems
down the line.


CONCEPT
- Introducing public setter may circumvent safeguards in manually created setters of different name

TO REVIEW
- Introducing public setter may circumvent safeguards in manually created setters of different name

=end


=begin
Question 4

Let's practice creating an object hierarchy.

Create a class called Greeting with a single instance method called greet that takes a string argument
and prints that argument to the terminal.

Now create two other classes that are derived from Greeting: one called Hello and one called Goodbye.
The Hello class should have a hi method that takes no arguments and prints "Hello". The Goodbye class
should have a bye method to say "Goodbye". Make use of the Greeting class greet method when implementing
the Hello and Goodbye classes - do not use any puts in the Hello or Goodbye classes.


My answer:

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end


Solution
This code should look familiar! See Question 1 from Practice Problems: Easy 3.

class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end


CONCEPTS
- Class definition
- Instance method inheritance
- Method lookup path
=end


=begin
Question 5

You are given the following class that has been implemented:

class KrispyKreme
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
end

And the following specification of expected behavior:

donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1
  => "Plain"

puts donut2
  => "Vanilla"

puts donut3
  => "Plain with sugar"

puts donut4
  => "Plain with chocolate sprinkles"

puts donut5
  => "Custard with icing"

Write additional code for KrispyKreme such that the puts statements will work as specified above.
=end

class KrispyKreme
  attr_reader :filling_type, :glazing
  
  def initialize(filling_type, glazing)
    @filling_type = filling_type
    @glazing = glazing
  end
  
  def to_s
    description = filling_type ? filling_type : 'Plain'
    description += " with #{glazing}" if glazing
    description
  end
end



donut1 = KrispyKreme.new(nil, nil)
donut2 = KrispyKreme.new("Vanilla", nil)
donut3 = KrispyKreme.new(nil, "sugar")
donut4 = KrispyKreme.new(nil, "chocolate sprinkles")
donut5 = KrispyKreme.new("Custard", "icing")

puts donut1

puts donut2

puts donut3

puts donut4

puts donut5

=begin
Solution
We need to define the to_s method for the class, and then have logic that can synthesize the
name based on the combinations of filling and glazing.

class KrispyKreme
  # ... keep existing code in place and add the below...
  def to_s
    filling_string = @filling_type ? @filling_type : "Plain"
    glazing_string = @glazing ? " with #{@glazing}" : ''
    filling_string + glazing_string
  end
end

Note that we can choose to create attr_reader directives for the filling and glazing instance
variables if we want to avoid use of the @ for accessing those instance variables and make
the to_s easier to read.

CONCEPTS
- Override default to_s
=end


=begin
Question 6

If we have these two methods in the Computer class:

class Computer
  attr_accessor :template

  def create_template
    @template = "template 14231"
  end

  def show_template
    template
  end
end

and

class Computer
  attr_accessor :template

  def create_template
    self.template = "template 14231"
  end

  def show_template
    self.template
  end
end

What is the difference in the way the code works?

My answer:
In the create template instance method, the first example writes to the instance variable
directly while the second example writes using the setter created
In the show template instance method, both returns the instance variable using the getter,
but the self is redundant in the second example.


Solution


There's actually no difference in the result, only in the way each example accomplishes the task.
Compare both show_template methods. We can see in the first example that it works fine without
self, therefore, self isn't needed in the second example. This is because show_template invokes
the getter method template, which doesn't require self, unlike the setter method.

Both examples are technically fine, however, the general rule from the Ruby style guide is to
"Avoid self where not required."

CONCEPTS
- self not needed in getter but required in setter
=end


=begin
Question 7

How could you change the method name below so that the method name is more clear and less repetitive?

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def light_status
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end
=end

class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def info
    "I have a brightness level of #{brightness} and a color of #{color}"
  end

end

# We can change the instance method name from light_status to info. This make method
# invocation less likely to have light repeated and more readable e.g. mylight.light_status vs mylight.info


=begin
Solution
Currently the method is defined as light_status, which seems reasonable. But when using or invoking the method,
we would call it like this: my_light.light_status. Having the word "light" appear twice is redundant. Therefore,
we can rename the method to just status, and we can invoke it like as my_light.status. This reads much better
-- remember, you're writing code to be readable by others as well as your future self.

CONCEPT
- Naming methods to avoid repetition and improving readability
=end
