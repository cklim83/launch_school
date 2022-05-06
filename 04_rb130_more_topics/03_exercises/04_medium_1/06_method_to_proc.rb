=begin

Method to Proc

In our Ruby course content on blocks, we learn about "symbol to proc"
and how it works. To review briefly, consider this code:

comparator = proc { |a, b| b <=> a }

and the Array#sort method, which expects a block argument to express how
the Array will be sorted. If we want to use comparator to sort the Array,
we have a problem: it is a proc, not a block. The following code:

array.sort(comparator)

fails with an ArgumentError. To get around this, we can use the proc to
block operator & to convert comparator to a block:

array.sort(&comparator)

This now works as expected, and we sort the Array in reverse order.

When applied to an argument object for a method, a lone '&' causes ruby to
try to convert that object to a block. If that object is a proc, the
conversion happens automatically, just as shown above. If the object is
not a proc, then & attempts to call the #to_proc method on the object first.
Used with symbols, e.g., &:to_s, Ruby creates a proc that calls the #to_s
method on a passed object, and then converts that proc to a block. This is
the "symbol to proc" operation (though perhaps it should be called "symbol
to block").

Note that &, when applied to an argument object is not the same as an &
applied to a method parameter, as in this code:

def foo(&block)
  block.call
end

While & applied to an argument object causes the object to be converted to
a block, & applied to a method parameter causes the associated object to be
converted to a proc. In essence, the two uses of & are opposites.

Did you know that you can perform a similar trick with methods? You can apply
the & operator to an object that contains a Method; in doing so, Ruby calls
Method#to_proc.

Using this information, together with the course page linked above, fill in
the missing part of the following code so we can convert an array of integers
to base 8 (octal numbers). Use the comments for help in determining where to
make your modifications, and make sure to review the "Approach/Algorithm"
section for this exercise; it should prove useful.

def convert_to_base_8(n)
  n.method_name.method_name # replace these two method calls
end

# The correct type of argument must be used below
base8_proc = method(argument).to_proc

# We'll need a Proc object to make this code work. Replace `a_proc`
# with the correct object
[8, 10, 12, 14, 16, 33].map(&a_proc)

The expected return value of map on this number array should be:

[10, 12, 14, 16, 20, 41]

You don't need a deep understanding of octal numbers -- base 8 -- for this
problem. It's enough to know that octal numbers use the digits 0-7 only, much
as decimal numbers use the digits 0-9. Thus, the octal number 10 is equivalent
to the decimal number 8, octal 20 is the same as decimal 16, octal 100 is the
same as decimal 64, and so on. No math is needed for this problem though; see
the Approach/Algorithm section for some hints.


Hint:
To solve this problem you'll need to do a bit of research. Refer to this page
on the Integer class instance method, to_s (https://ruby-doc.org/core-3.1.2/Integer.html).
You will also have to use one method (https://ruby-doc.org/core-3.1.2/Object.html#method-i-method)
from the Object class.

NOTE: This exercise is tricky. If you can't finish it, feel free to follow
along with the solution; it may be treated as a learning experience rather
than something you should be able to figure out on your own.

=end

def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8)

[8, 10, 12, 14, 16, 33].map(&base8_proc) # => [10, 12, 14, 16, 20, 41]

=begin
Solution

def convert_to_base_8(n)
  n.to_s(8).to_i
end

base8_proc = method(:convert_to_base_8).to_proc

[8, 10, 12, 14, 16, 33].map(&base8_proc) # => [10, 12, 14, 16, 20, 41]

Discussion

Let's start with our convert_to_base_8 method. Notice that this method takes
a number-like argument, n. We also see that to_s(n) is using a number-like
argument as well. This seems like a good place to start. We'll find that this
form of to_s converts integers into the String representation of a base-n
number.

Right now, we use decimals (base 10), so to convert a number n to base 8, we
call to_s(8) on it. If we take 8 as an example, then calling 8.to_s(8) returns
"10". But, from the expected return value, we can see that we want an Integer,
not a String. Therefore, we also need to call to_i on the return value of
n.to_s(8).

Next, let's handle the missing pieces of this line:

base8_proc = method(argument).to_proc

Based on the information from the "Approach/Algorithm" section, we know to
research method from class Object. After looking at that documentation, we
see that a symbol of an existing method may be passed into method method(sym).
If we do that, the functionality of that method gets wrapped in a Method
object, and we may now do work on that object.

We want to convert our array of numbers to base 8, so it makes sense to make
a method object out of the convert_to_base_8 method. This leaves us with:

base8_proc = method(:convert_to_base_8).to_proc

The final piece of this exercise asks us fill in this line. 

[8,10,12,14,16,33].map(&a_proc). We want access to the functionality of method
convert_to_base_8, and we know that it has been converted to a Proc object, so
that Proc is the natural choice. Remember that using just & (and not &:) lets
us turn a Proc object to a block. A block that can now be used with map.

There. All done. One last piece of information that may be good to mention is
how a method looks when converted to a Proc. You can imagine the conversion to
look like that:

def convert_to_base_8(n)
  n.to_s(8).to_i
end

# ->

Proc.new { |n| n.to_s(8).to_i }
#when we use & to convert our Proc to a block, it expands out to...

# ->
[8, 10, 12, 14, 16, 33].map { |n| n.to_s(8).to_i }
=end


=begin

CONCEPT (VERY IMPORTANT)

- Ampersand & operator (https://ablogaboutcode.com/2012/01/04/the-ampersand-operator-in-ruby)
  - & can be prepended to the last parameter in a method definition. Used in this context,
    it symbolizes an explicit block parameter and the & will convert the given blockto a simple proc
  
  - &, can also be prepended to an argument in a method invocation. In this context, it will do one of the following:
    - If that argument is referencing a proc, & will convert it to a block
    - If the argument is not referencing a proc (e.g. it is a symbol or another object), & will first call #to_proc on
      that object to try to convert it into a proc before converting it to a block
  
  - Why the following doesn't work?
    
    def convert_to_base_8(n)
      n.to_s(8).to_i
    end

    [8, 10, 12, 14, 16, 33].map(&:convert_to_base_8)
    
    In Ruby 2.7 and earlier, the above returns ArgumentError (wrong number of arguments (given 0, expected 1)).
    - Just like [1, 2, 3].map(&:to_s) becomes [1, 2, 3].map { |n| n.to_s }, [8, 10, 12, 14, 16, 33].map(&:convert_to_base_8)
      is converted to  [8, 10, 12, 14, 16, 33].map { |n| n.convert_to_base_8 }. Since convert_to_base_8 is expecting 1 argument
      but is not receiving 1, we get an argument error. A workaround this could be to conver the method to one not requiring an
      argument. Since n, the method call will take on the elements in the array, we can just use self in the method body and do
      without the argument.
      
      def convert_to_base_8
        self.to_s(8).to_i
      end
      
  
    From Ruby 3.0 onwards, the above returns in `map': private method `convert_to_base_8' called for 8:Integer (NoMethodError)
    - It seems that from Ruby 3.0 onwards, all methods defined in main are default private methods in Object class
    
    Some background
    
    - the main object is a little strange. It behaves both like an instance of Object, 
    
      3.0.3 :001 > self
      => main 
      3.0.3 :002 > self.instance_of?(Object)
      => true 
      3.0.3 :003 > self.class
      => Object
    
    - but is also like the Object class itself. So if we define a method in the main scope,
    that method is available to instances of Object, and also to and classes that sub-class
    from Object (which is all custom classes). 
    Since Ruby 3.0 onwards, these methods are private
    
      3.0.3 :004 > def convert_to_base_8(n)
      3.0.3 :005 >   n.to_s(8).to_i
      3.0.3 :006 > end
      => :convert_to_base_8 
    
      3.0.3 :007 > class MyClass; end
      => nil
      3.0.3 :008 > my_obj = MyClass.new
      => #<MyClass:0x00007fa3a7121248>
      3.0.3 :009 > my_obj.private_methods
      => 
      [:timeout,
       :DelegateClass,
       :convert_to_base_8,
       ...]
       
    - Hence [8, 10, 12, 14, 16, 33].map(&:convert_to_base_8) becomes [8, 10, 12, 14, 16, 33].map { |n| n.convert_to_base_8 },
      while complains we are trying to call a private method #convert_to_base_8 on an integer 8 (first element of array)
    - Integer and all custom class are subclasses of Object, hence they all inherit the private method #convert_to_base_8
    - We suspect prior to Ruby 3.0, methods defined in main are public by default since it complain of ArgumentError rather 
      than private method error when the same code is run in Ruby 2.7
    
    - To solve this we could put public before convert_to_base_8 method definition
      
      public

      def convert_to_base_8(n)
        n.to_s(8).to_i
      end
    
    - Or we could define convert_to_base_8(n) as a public method of Integer class (not recommended since we will be altering Integer class)
    
    - Once we do that, we will get the ArgumentError seen in Ruby 2.7.
 

  - Object#method(:method_name) will wrap the method into a Method object. & will then automatically trigger Method#to_proc on the
    Method object (hence the extra to_proc call in base8_proc = method(:convert_to_base_8).to_proc is actually 
    not required) and then convert that proc object into the following equivalent block
    
    [8, 10, 12, 14, 16, 33].map do |n|
      n.to_s(8).to_i
    end
    
  - Thus Object#method(sym) offers a workaround for methods with arguments to also use the symbol to block shortcut syntax.
  
    # No argument method Integer#to_s
    [10, 20, 30].map(&:to_s) # equivalent to [10, 20, 30].map { |n| n.to_s }
    => ['10', '20', '30']
    
    # Two argument method
    def two_arg_method(a, b)
      a + b
    end
    
    my_method_obj = method(:two_arg_method)
    [1, 2, 3, 4].reduce(0, &my_method_obj) # equivalent to [1,2,3,4].reduce { |a, b| a + b }  
    => 10
    
=end
 
  
  