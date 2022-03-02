=begin
You started writing a very basic class for handling files. However,
when you begin to write some simple test code, you get a NameError.
The error message complains of an uninitialized constant File::FORMAT.

What is the problem and what are possible ways to fix it?

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true

puts blog_post
=end

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name) # copy content of self to a new target_file_name
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes) # argument is a string converted to bytes

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFile     # true
puts copy_of_blog_post.read == blog_post.read # true  # This is array == array since read returns the byte content which is an array

puts blog_post

=begin
My answer:
This example shows the lexical scope of constants i.e.
the scope of a constant lies within the group of code it
is defined in. In this case, FORMAT in File#to_s is scoped 
within File by default. Hence, to_s will refer to the 
File::FORMAT even when it is called by a child object.
To resolve this, we change the binding of the constant
so that it can use the constant FORMAT of its caller class
using self.class::FORMAT
=end


=begin
Solution

class File
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name)
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{self.class::FORMAT}"
  end
end

class MarkdownFile < File
  FORMAT = :md
end

class VectorGraphicsFile < File
  FORMAT = :svg
end

class MP3File < File
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFile.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes)

puts blog_post

Discussion

The error occurs when we use the File#to_s method. The reason is our use of
the constant FORMAT. When Ruby resolves a constant, it looks it up in its
lexical scope, in this case in the File class as well as in all of its
ancestor classes. Since it doesn't find it in any of them, it throws a
NameError.

There are several ways to fix this. For example, instead of defining to_s
in the File class, we could define it in each of the subclasses, in which
the FORMAT constant is defined. But this would duplicate the exact same
method, so the DRY principle advises us against it.

Alternatively, we can add explicit namespacing, as we do in our solution,
by prepending the class name. Which class? This will be determined by the
subclass from which we are calling to_s. We can reference this subclass
as self.class - the class of the caller of the method (blog_post in our
example). Using self.class offers the same flexibility that we use on
line 12 when creating a new instance of the subclass from which we are
calling new.

Another option is to not use a constant but, for example, a method:

class File
  # code omitted

  def to_s
    "#{name}.#{format}"
  end
end

class MarkdownFile < File
  def format
    :md
  end
end

class VectorGraphicsFile < File
  def format
    :svg
  end
end

class MP3File < File
  def format
    :mp3
  end
end

Of course, you could also use an instance variable to store the format,
although this doesn't convey the fact that the format of a particular
file is fixed and cannot change. Which option you pick is mainly a
design choice.

Finally, note that this example is only for illustration purposes. Ruby
has a File class, and there's really no good reason to write one ourselves.

Further Exploration

If you aren't familiar with Module#alias_method, take a moment to view
Ruby's documentation. You don't need to memorize this method, but get
in the habit of referring to documentation when you see code you aren't
familiar with.
=end


=begin

CONCEPTS
- Lexical scope of constant
- Constant inheritance


TO REVIEW
- FORMAT referenced in to_s will search within
  the class itself OR ITS ANCESTORS if not found within 
  the class (see below example)
  
- We could also solve the problem using instance methods since
  the method lookup path will always search for a method starting
  from the class of calling object.
  
- Module#alias_method
=end

class Parent
  FORMAT = "FileFather"
end

class Files < Parent
  attr_accessor :name, :byte_content

  def initialize(name)
    @name = name
  end

  alias_method :read,  :byte_content
  alias_method :write, :byte_content=

  def copy(target_file_name) 
    target_file = self.class.new(target_file_name)
    target_file.write(read)

    target_file
  end

  def to_s
    "#{name}.#{FORMAT}"
  end
end

class MarkdownFiles < Files
  FORMAT = :md
end

class VectorGraphicsFiles < Files
  FORMAT = :svg
end

class MP3Files < Files
  FORMAT = :mp3
end

# Test

blog_post = MarkdownFiles.new('Adventures_in_OOP_Land')
blog_post.write('Content will be added soon!'.bytes) # argument is a string converted to bytes

copy_of_blog_post = blog_post.copy('Same_Adventures_in_OOP_Land')

puts copy_of_blog_post.is_a? MarkdownFiles    # true
puts copy_of_blog_post.read == blog_post.read # true  # This is array == array since read returns the byte content which is an array

puts blog_post # Print Adventures_in_OOP_Land.FileFather
