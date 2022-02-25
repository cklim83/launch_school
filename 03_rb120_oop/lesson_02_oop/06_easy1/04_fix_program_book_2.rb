=begin
Complete this program so that it produces the expected output:

class Book
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)

Expected output:

The author of "Snow Crash" is Neil Stephenson.
book = "Snow Crash", by Neil Stephenson.
=end

class Book
  attr_accessor :title, :author
  
  def to_s
    %("#{title}", by #{author})
  end
end

book = Book.new
book.author = "Neil Stephenson"
book.title = "Snow Crash"
puts %(The author of "#{book.title}" is #{book.author}.)
puts %(book = #{book}.)


=begin
Solution

Add the following code to the class (between lines 1 and 2 will be fine):

attr_accessor :author, :title

Discussion

If you try to run this code, you'll see something like this:

x.rb:11:in `<main>': undefined method `author=' for #<Book:0x007ff28403e958>
(NoMethodError)

Hmm...we are attempting to set the book author by calling the author= method.
Obviously, we need a setter for @author, and by examination of the next line,
we can see that we also need a setter for @title. So, we define those setters:

attr_writer :author, :title

You run your code again, and this time get:

x.rb:12:in `<main>': undefined method `title' for #<Book:0x007fbe72836980>
(NoMethodError)

Looks like you need a getter for @title, as well as the setter. Look more
closely at that line, we also note that we need a getter for @author. So,
we change the previously entered attr_writer line to:

attr_accessor :author, :title

The program now works as expected.

Further Exploration

What do you think of this way of creating and initializing Book objects?
(The two steps are separate.) Would it be better to create and initialize
at the same time like in the previous exercise? What potential problems,
if any, are introduced by separating the steps?

It is better to create and initialize together if there is no need to mutate
the state after creation. By separating the steps, we need to provide
public methods to modify the internal state after the object is created, 
potentially opening a pathway to violating the integrity of the state 
of the objects of this class.

=end