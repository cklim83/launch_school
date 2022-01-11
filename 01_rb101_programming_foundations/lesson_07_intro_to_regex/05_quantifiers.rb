=begin
Write a regex that matches any word that begins with b and ends with an e,
and has any number of letters in-between. You may limit your regex to
lowercase letters. Test it with these strings.

To be or not to be
Be a busy bee
I brake for animals.

There should be four matches.

My answer:
/b[a-z]*e/      => /b.*e/ will match "be or not to be", "busy bee" and "brake" due to greedy nature

Given answer:
Solution

/\bb[a-z]*e\b/

This regex should match the words be (both instances), bee, and brake.


TO REVIEW
- using lazy match b.*?e\b will still match "be", "be", "busy bee" and "brake" so not quite the single word answer
- we should endeavour to use \b word boundary to precisely ensure single word matches.
=end


=begin
Write a regex that matches any line of text that ends with a ?. Test it with these strings.

What's up, doc?
Say what? No way.
?
Who? What? Where? When? How?

There should be three matches.

My answer:
We want a line rather than string match, so use $ rather than \z to match its end
/.*[?]$/ or /.*\?$/.

Solution
/^.*\?$/

This regex should match the first, third, and fourth lines, but not the second line.
Note the use of .*; you'll see this often in regex. It matches any sequence of
characters, but, by default, does not match a newline character. It's how you ignore
everything between two points when matching.

Note that the ? must be \-escaped since we want to match a literal ?.

TO REVIEW
- as one of our test case has only ?, we must use .* and not .+
- ? is a meta character for lazy match if used on its has to be escaped or put in [] to get
  its literal meaning. Otherwise /.*?$/ will just match all four lines as as whole. Putting 
  ? in () like /.*(?)$/ will also generate an undefined group option error since ? still exhibit
  meta character behavior in () and needs to be escaped.
- I should use a ^ to indicate start of a line
=end


=begin
Write a regex that matches any line of text that ends with a ?, but does not match a line
that consists entirely of a single ?. Test it with the strings from the previous exercise.

There should be two matches.

My answer:
/^.+\?$/

Solution:
/^.+\?$/

This regex should match the first and fourth lines, but not the second or third. 
The .+ pattern makes the regex match at least one character before it attempts to match the ?.
=end


=begin
Write a regex that matches any line of text that contains nothing but a URL. For this
exercise, a URL begins with http:// or https://, and continues until it detects a
whitespace character or end of line. Test your regex with these strings:

http://launchschool.com/
https://mail.google.com/mail/u/0/#inbox
htpps://example.com
Go to http://launchschool.com/
https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello
    http://launchschool.com/

There should be two matches.

My answer:
/^https*:\/{2}[^\s]+\s*$/


Solution:
/^https?:\/\/\S*$/

This regex should match the first and second text lines, but none of the others.
The third line doesn't match because of a misspelling; the fourth and fifth don't match
because of extra content, and the last doesn't match because of the leading spaces.

The regex begins with a line anchor, ^, and then the http part of the URL followed by
an optional s. Next, we have the :, and two / characters (both / characters must be \-escaped).
We then have the rest of the URL, which we achieve by matching a string of non-whitespace
characters. We also require an explicit line anchor, $, to prevent matching a URL that
isn't at the end of the line.

TO REVIEW
- We can use \S instead of [^\s]
- The non-whitespace after // is optional but not in my solution
=end


=begin
Modify your regex from the previous exercise so the URL can have optional leading
or trailing whitespace, but is otherwise on a line by itself. To test your regex
with trailing whitespace, you must add some spaces to the end of some lines in
your sample text.

http://launchschool.com/  
https://mail.google.com/mail/u/0/#inbox   
htpps://example.com   
Go to http://launchschool.com/
https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello
    http://launchschool.com/

There should be three matches.

My answer:
/^\s*https?:\/\/\S*\s*$/


Solution:
/^\s*https?:\/\/\S*\s*$/

This regex should match the URLs on the first, second, and last lines.
=end


=begin
Modify your regex from the previous exercise so the URL can appear anywhere on
each line, so long as it begins at a word boundary.

http://launchschool.com/  
https://mail.google.com/mail/u/0/#inbox   
htpps://example.com   
Go to http://launchschool.com/
https://user.example.com/test.cgi?a=p&c=0&t=0&g=0 hello
    http://launchschool.com/

There should be five matches.

My answer:
/\bhttps?:\/\/\S*\s*\b/

Solution
/\bhttps?:\/\/\S*/

This solution should match all of the URLs above. (Note that the third line is a not a URL.)


TO REVIEW
- My answer have the redundant trailing space match \s* and \b word boundary would not make sense
  if there are trailing spaces (would be \B if there are trailing spaces and \b if it ends with a word)
=end


=begin
Write a regex that matches the last word in each line of text. For this exercise, assume that
words are any sequence of non-whitespace characters. Test your regex against these strings:

What's up, doc?
I tawt I taw a putty tat!
Thufferin' thuccotath!
Oh my darling, Clementine!
Camptown ladies sing this song, doo dah.

There should be five matches.

My answer:
/\b\S+$/

Solution:
/\S+$/

Your solution should match doc?, tat!, thuccotath!, Clementine!, and dah.


TO REVIEW
- \b not necessary since \S will not match a space so it would 
  automatically look for continguous non-whitepace at the end of each line
=end


=begin
Write a regex that matches lines of text that contain at least 3, but no
more than 6, consecutive comma separated numbers. You may assume that every
number on each line is both preceded by and followed by a comma. Test your
regex against these strings:

,123,456,789,123,345,
,123,456,,789,123,
,23,56,7,
,13,45,78,23,45,34,
,13,45,78,23,45,34,56,

There should be three matches.


My answer:
/^,([0-9]+,){3, 6}$/  => ^ and $ anchors needed else it would partially match the last line with >6 numbers 

Solution
/^,(\d+,){3,6}$/

Your solution should match the first, third, and fourth lines.

TO REVIEW
- \d is shortcut for [0-9]
- We use () to create a number + comma group for quantifier to act on 
=end


=begin
Challenge: Write a regex that matches lines of text that contain either 3 comma
separated numbers or 6 or more comma separated numbers. Test your regex against
these strings:

123,456,789,123,345
123,456,,789,123
23,56,7
13,45,78,23,45,34
13,45,78,23,45,34,56

There should be three matches.

My answer:
/^((\d+,){2}|(\d+,){5,})\d+$/ matches 23,56,7 and 13,45,78,23,45,34 and 13,45,78,23,45,34,56


Solution:
/(^(\d+,){2}\d+$|^(\d+,){5,}\d+$)/

Alternate Solution

/^(\d+,){2}((\d+,){3,})?\d+$/

Your solution should match the last three lines. Regex provide no simple way to say
something like three occurrences, or 6 or more occurrences. We have two approaches we
can take instead: either use alternation or use the ? quantifier to make part of the
pattern optional.

Our first solution uses alternation. Let's break it up a bit using "extended" syntax:

/
  (                  # Grouping for alternation
    ^(\d+,){2}\d+$   # Match precisely 3 numbers on a line
    |                # *or*
    ^(\d+,){5,}\d+$  # Match 6 or more numbers on a line
  )                  # All done
/x

Our alternate solution uses the ? quantifier instead. Breaking it down once again, we see:

/
  ^                  # Start of line
  (\d+,){2}          # 2 numbers at start
  (                  # followed by...
    (\d+,){3,}       #    at least 3 more numbers
  )?                 #    that are optional
  \d+                # followed by one last number
  $                  # end of line
/x

Note the use of the 'x' option on these broken out patterns. This Ruby-specific option
is useful when you have a convoluted regex. It lets you write a regex over several lines,
and put comments on each line. See the Ruby Regexp documentation for more information.

In a real program, you may instead choose to use two separate regex:

if text.match(/^(\d+,){2}\d+$/) || text.match(/^(\d+,){5,}\d+$/)

This code is easier to understand, but not always practical.


TO REVIEW
- We can use /x option to split out complex patterns, then comment for clarity
=end


=begin
Challenge: Write a regex that matches HTML h1 header tags, e.g.,

<h1>Main Heading</h1>
<h1>Another Main Heading</h1>
<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>

and the content between the opening and closing tags. If multiple header tags appear
on one line, your regex should match the opening and closing tags and the text content
of the headers, but nothing else. You may assume that there are no nested tags in the
text between <h1> and </h1>.


My answer:
 
# using lazy match ? after .* to prevent greedy match of 
<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1> and omit the <p>..</p> tags

<h1>.*?<\/h1> 


Solution:
/<h1>.*?<\/h1>/

For this exercise, we need to use a "lazy" quantifier instead of the default greedy
quantifier, so we use .*? to match the text in between the <h1> opening tag and its
closing tag, </h1>.

What would happen if you omitted the '?'? Try both the correct regex and the one with
a greedy quantifier (/<h1>.*<\/h1>/) against this HTML to see:

<h1>ABC</h1> <p>Paragraph</p> <h1>DEF</h1><p>Done</p>
=end