=begin

HEY YOU!

String#upcase! is a destructive method, so why does this code print
HEY you instead of HEY YOU? Modify the code so that it produces the
expected output.


def shout_out_to(name)
  name.chars.each { |c| c.upcase! }

  puts 'HEY ' + name
end

shout_out_to('you') # expected: 'HEY YOU'
=end


=begin
My answer:
`name.chars` returns a new array with elements containing the same value
as the characters referenced by name. Since the array is the calling object,
`#upcase!` is mutating the elements of the array and not the string referenced
by name. Thus puts 'HEY ' + name is actually concatenating `HEY` with 'you'
to print out 'HEY you'. To get the intended output, we can just call upcase on
the object referenced by name directly.
=end


def shout_out_to(name)
  puts 'HEY ' + name.upcase
end

shout_out_to('you') # expected: 'HEY YOU'


=begin
Solution

def shout_out_to(name)
  name.upcase!

  puts 'HEY ' + name
end

shout_out_to('you')

Discussion

The String#chars method returns an array of the characters in a string, 
so name.chars in our example returns ['y', 'o', 'u']. Note that these
character strings are new String objects, different from the name string,
and it's those objects that we mutate on line 2. On line 4, name is
therefore still 'you'.

The solution is to upcase name directly, either as shown in the solution
above or using the non-destructive String#upcase method as follows:

def shout_out_to(name)
  puts 'HEY ' + name.upcase
end
=end


=begin
TO REVIEW
- we cannot mutate the string calling each_char since each_char returns 
  a new string object to the block argument each time it is called
  
  "abc".each_char { |char| char.upcase! }
  => "abc"
=end