=begin

Test swap method - Text

For this exercise you'll be given a sample text file and a starter class.
The sample text's contents will be saved as a String to an instance
variable in the starter class.

The Text class includes a #swap method that can be used to replace all
occurrences of one letter in the text with another letter. And for this
exercise we will swap all occurrences of 'a' with 'e'.

Your task is to write a test suite for class Text. In that test suite
write a test for the Text method swap. For this exercise, you are required
to use the minitest methods #setup and #teardown. The #setup method contains
code that will be executed before each test; #teardown contains code that
will be executed after each test.
=end

require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open("./sample_text.txt", "r") 
    @text = Text.new(@file.read)
  end
  
  def test_swap
    actual = @text.swap('a', 'e')
    expected_result = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT
    
    assert_equal expected_result, actual
  end
  
  def teardown
    @file.close
  end
end


=begin
Solution

require 'minitest/autorun'
require_relative 'text'

class TextTest < Minitest::Test
  def setup
    @file = File.open('./sample_text.txt', 'r')
  end

  def test_swap
    text = Text.new(@file.read)
    actual_text = text.swap('a', 'e')
    expected_text = <<~TEXT.chomp
    Lorem ipsum dolor sit emet, consectetur edipiscing elit. Cres sed vulputete ipsum.
    Suspendisse commodo sem ercu. Donec e nisi elit. Nullem eget nisi commodo, volutpet
    quem e, viverre meuris. Nunc viverre sed messe e condimentum. Suspendisse ornere justo
    nulle, sit emet mollis eros sollicitudin et. Etiem meximus molestie eros, sit emet dictum
    dolor ornere bibendum. Morbi ut messe nec lorem tincidunt elementum vitee id megne. Cres
    et verius meuris, et pheretre mi.
    TEXT

    assert_equal expected_text, actual_text
  end

  def teardown
    @file.close
  end
end

Discussion

To write this test we'll need to first create an instance of class Text.
Then, we need to pass it the text we want to work on. To do that we'll
have to read that text from the sample text file. First, we must open the
file for reading. We want to keep things directly related to our test in
our test method. So, any code that is necessary to setup the test is a
perfect candidate for the #setup method. We do so in our solution by
opening the file in question and assigning the file object to an instance
variable.

Once we have passed in the contents of that file to the Text class, we're
ready to make the command that will lead to the assertion for this test.
That command is the call to Text#swap. In this case, the exercise asks us
to use a and e as the letters to swap out. The return value of this Text#swap
method is what we will use to test that this method is working as intended.

Next, we need a String that we can test against the return value of Text#swap.
This will be our expected value for the later assertion. To get this String,
we just take the contents of the file and process it manually with our text
editor to replace all of the as with es.

Finally, we use assert_equal to ensure that the expected value of the text
is equal to the actual value.
=end


=begin
TO REVIEW

- Create multiline string using HEREDOC. <<~ will remove indentation, <<- will not 

  variable_name = LABEL <<~ 
    ....
  LABEL

- File.open(filename, mode) will return a file object that we need to close later in teardown. Passing it
  with a block will automatically close the file post processing.
  
  File.open(filename, mode) do |file|
    ... 
  end
  
- def setup is executed before every test, and def teardown is executed after every test.

=end