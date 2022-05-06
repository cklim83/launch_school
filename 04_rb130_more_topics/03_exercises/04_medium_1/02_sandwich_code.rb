=begin

Text Analyzer - Sandwich Code

Fill out the rest of the Ruby code below so it prints output like that shown
in "Sample Output." You should read the text from a simple text file that you
provide. (We also supply some example text below, but try the program with
your text as well.)

This question requires that you read a simple text file. Try searching the
Web for information on how to do this, and also take a look at the File
class in the Ruby documentation. If you can't figure it out on your own,
don't worry: just put the data directly into your program; an Array with
one element per line would be ideal.

Read the text file in the #process method and pass the text to the block
provided in each call. Everything you need to work on is either part of
the #process method or part of the blocks. You need no other additions
or changes.

The text you use does not have to produce the same numbers as the sample
output but should have the indicated format.

class TextAnalyzer
  def process
    # your implementation
  end
end

analyzer = TextAnalyzer.new
analyzer.process { # your implementation }
analyzer.process { # your implementation }
analyzer.process { # your implementation }

Sample Text File:
sample_text.txt

Eiusmod non aute commodo excepteur amet consequat ex elit. Ut excepteur ipsum
enim nulla aliqua fugiat quis dolore do minim non. Ad ex elit nulla commodo
aliqua eiusmod aliqua duis officia excepteur eiusmod veniam. Enim culpa laborum
nisi magna esse nulla ipsum ex consequat. Et enim et quis excepteur tempor ea
sit consequat cupidatat.

Esse commodo magna dolore adipisicing Lorem veniam quis ut labore pariatur quis
aliquip labore ad. Voluptate ullamco aliquip cillum cupidatat id in sint ipsum
pariatur nisi adipisicing exercitation id adipisicing qui. Nulla proident ad
elit dolore exercitation cupidatat mollit consequat enim cupidatat tempor
aliqua ea sunt ex nisi non.

Officia dolore labore non labore irure nisi ad minim consectetur non irure
veniam dolor. Laboris cillum fugiat reprehenderit elit consequat ullamco veniam
commodo.

Sample Output:

3 paragraphs
15 lines
126 words

Hint: You may assume that paragraphs have one empty line between them and that
each line ends with a newline character. A single space appears between all words.
=end

class TextAnalyzer
  def process
    file = File.open("02a_sample_text.txt")
    yield(file)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |file| puts "#{file.readlines("\n\n").size} paragraphs" }
analyzer.process { |file| puts "#{file.readlines("\n").size} lines"}
analyzer.process { |file| puts "#{file.read.split.size} words"}


=begin
Solution

class TextAnalyzer
  def process
    file = File.open('sample_text.txt', 'r')
    yield(file.read)
    file.close
  end
end

analyzer = TextAnalyzer.new
analyzer.process { |text| puts "#{text.split("\n\n").count} paragraphs" }
analyzer.process { |text| puts "#{text.split("\n").count} lines" }
analyzer.process { |text| puts "#{text.split(' ').count} words" }

Discussion

For this exercise, you must fill in the missing parts of the code we gave you.
You know the output we want; you must somehow produce that output.

Start with the #process method; we told you that #process should read some
text from a file, and then pass that text to the block for further processing.
The usual approach for such read-and-process code looks like this:

file = File.open('sample_text.txt', 'r')
# do processing here
file.close

Remember to always close files when you finish using them.

Since we're supposed to pass the text content of the file to the block, we
must load the file's content and call the block, which we do with
yield(file.read):

file = File.open('sample_text.txt', 'r')
yield(file.read)
file.close

At this point we have what we call "sandwich code"; it performs some pre-
and post-processing for some arbitrary action. Here, the pre-processing opens
a file, and the post-processing closes it. Together, they sandwich the action
that loads the file's contents and passes it to a block.

Since we're passing text to the blocks, the blocks should capture that text:

analyzer.process { |text| puts ... }
analyzer.process { |text| puts ... }
analyzer.process { |text| puts ... }

Judging from the partial code, you can see that each block contains a puts
statement, so we must provide arguments to puts that perform the necessary
processing and format the answer accordingly. The last step fills in these
details: for each, we use String#split and Array#count as you can see in
the Solution.
=end


=begin
TO REVIEW (Important)

- The common sandwich code is to open the file and the close it after processing

- use #read to read and return file content as string. It is better to pass
  the text to the block rather than a file handler as we do not want to 
  give permission for unauthorised changes to file to method users

- use split("\n\n"), split('\n') and split to get paragraph, line and words.

- #count will return the number of elements.
=end