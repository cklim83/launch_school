=begin
1. Write a regex that matches an uppercase K. Test it with these strings:

Kx
BlacK
kelly

There should be two matches.
=end

puts "Kx matches K" if "Kx".match(/K/)
puts "BlacK matches K" if "BlacK".match(/K/)
puts "kelly matches K" if "kelly".match(/K/)

# Given answer: /K/


=begin
2. Write a regex that matches an uppercase or lowercase H. Test it with
these strings:

Henry
perch
golf

There should be two matches.
=end

pattern_1 = /H/i    # using flags
pattern_2 = /(h|H)/ # using alternation

puts "Henry matches either H or h using regex pattern `/H/i`" if "Henry".match(pattern_1)
puts "Henry matches either H or h using regex pattern `/(h|H)/`" if "Henry".match(pattern_2)
puts "perch matches either H or h using regex pattern `/H/i`" if "perch".match(pattern_1)
puts "perch matches either H or h using regex pattern `/(h|H)/`" if "perch".match(pattern_2)
puts "golf matches either H or h using regex pattern `/H/i`" if "golf".match(pattern_1)
puts "golf matches either H or h using regex pattern `/(h|H)/`" if "golf".match(pattern_2)

# Given answers: /h/i or /(h|H)/


=begin
3. Write a regex that matches the string dragon. Test it with these 
strings:

snapdragon
bearded dragon
dragoon

There should be two matches.
=end


puts "snapdragon matches dragon" if "snapdragon".match(/dragon/)
puts "bearded dragon matches dragon" if "bearded dragon".match(/dragon/)
puts "dragoon matches dragon" if "dragoon".match(/dragon/)

# Given answer: /dragon/


=begin
4. Write a regex that matches any of the following fruits: banana, 
orange, apple, strawberry. The fruits may appear in other words. 
Test it with these strings:

banana
orange
pineapples
strawberry
raspberry
grappler

There should be five matches.
=end

pattern = /(banana|orange|apple|strawberry)/

puts "banana matches regex: #{pattern}" if "banana".match(pattern)
puts "orange matches regex: #{pattern}" if "orange".match(pattern)
puts "pineapples matches regex: #{pattern}" if "pineapples".match(pattern)
puts "strawberry matches regex: #{pattern}" if "strawberry".match(pattern)
puts "raspberry matches regex: #{pattern}" if "raspberry".match(pattern)
puts "grappler matches regex: #{pattern}" if "grappler".match(pattern)

=begin
Given answer:
/(banana|orange|apple|strawberry)/

Note that our regex matches apple in the words pineapples and grappler. You'll learn how to prevent this later on.

The solution matches everything except raspberry.
=end


=begin
5. Write a regex that matches a comma or space. Test your regex 
with these strings:

This line has spaces
This,line,has,commas,
No-spaces-or-commas

There should be seven matches.
=end

pattern = /(,| )/
puts "This line has spaces" if "This line has spaces".match(pattern)
puts "This,line,has,commas," if "This,line,has,commas,".match(pattern)
puts "No-spaces-or-commas" if "No-spaces-or-commas".match(pattern)

=begin
Given answer:
/( |,)/

The expression should match three spaces on line 1 and four commas on line 2.
=end


=begin
6. Challenge: Write a regex that matches blueberry or blackberry, 
but write berry precisely once. Test it with these strings:

blueberry
blackberry
black berry
strawberry

There should be two matches.

Hint: you need both concatenation and alternation.
=end

pattern = /(blue|black)berry/

puts "blueberry" if "blueberry".match(pattern)
puts "blackberry" if "blackberry".match(pattern)
puts "black berry" if "black berry".match(pattern)
puts "strawberry" if "strawberry".match(pattern)

=begin
Given answer:
/(blue|black)berry/

The key to this challenge is that concatenation works with patterns, not characters. Thus, we can concatenate (blue|black) with berry to produce the final result.

The expression matches the first two lines.

How come the regex doesn't match black berry?

My answer: there is a space before berry.
=end