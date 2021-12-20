=begin

Bannerizer

Write a method that will take a short line of text, and print it within a box.

Example:

print_in_box('To boldly go where no one has gone before.')
+--------------------------------------------+
|                                            |
| To boldly go where no one has gone before. |
|                                            |
+--------------------------------------------+

print_in_box('')
+--+
|  |
|  |
|  |
+--+

You may assume that the input will always fit in your terminal window.

=end

=begin
Problem
- input: String of text
- output: Display text in banner in standard output

Examples
- See above
- Assume length of banner = length of words + 4, text will fit in 1 line, breadth is 4
=end


def print_in_box(text)
  length = text.size
  horizontal_border = "+-" + ("-" * length) + "-+"
  empty_border = "| " + (" " * length) + " |"
  content = "| #{text} |"
  
  puts horizontal_border
  puts empty_border
  puts content
  puts empty_border
  puts horizontal_border
end


print_in_box('To boldly go where no one has gone before.')
print_in_box('')


=begin
Solution

def print_in_box(message)
   horizontal_rule = "+#{'-' * (message.size + 2)}+"
   empty_line = "|#{' ' * (message.size + 2)}|"

   puts horizontal_rule
   puts empty_line
   puts "| #{message} |"
   puts empty_line
   puts horizontal_rule
end

Discussion

This is a fairly straightforward solution. To simplify matters, we start out
by setting horizontal_rule and empty_line to appropriate values for the top
and bottom 2 lines of the box. The expression '-' * (message.size + 2) simply
creates a string of message.size + 2 hyphens; combined with the + at the
beginning and end of the string, this is just wide enough to draw the
horizontal lines while leaving room for one blank on either side of the message.

Further Exploration

Modify this method so it will truncate the message if it will be too wide to
fit inside a standard terminal window (80 columns, including the sides of the
box). For a real challenge, try word wrapping very long messages so they appear
on multiple lines, but still within a box.

=end