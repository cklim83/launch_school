=begin

Madlibs Revisited

Let's build another program using madlibs. We made a program like this in
the easy exercises. This time, the requirements are a bit different.

Make a madlibs program that reads in some text from a text file that you
have created, and then plugs in a selection of randomized nouns, verbs,
adjectives, and adverbs into that text and prints it. You can build your
lists of nouns, verbs, adjectives, and adverbs directly into your program,
but the text data should come from a file or other external source. Your
program should read this text, and for each line, it should place random
words of the appropriate types into the text, and print the result.

The challenge of this program isn't about writing your program; it's about
choosing how to represent your data. Choose the right way to structure your
data, and this problem becomes a whole lot easier. This is why we don't show
you what the input data looks like; the input representation is your
responsibility.

Example output:

The sleepy brown cat noisily
licks the sleepy yellow
dog, who lazily licks his
tail and looks around.

Example text data

The %{adjective} brown %{noun} %{adverb}
%{verb} the %{adjective} yellow
%{noun}, who %{adverb} %{verb} his
%{noun} and looks around.

Example replacement words

    adjectives: quick lazy sleepy ugly
    nouns: fox dog head leg
    verbs: jumps lifts bites licks
    adverb: easily lazily noisily excitedly
=end


=begin
Solution

ADJECTIVES = %w(quick lazy sleepy ugly).freeze
NOUNS      = %w(fox dog head leg cat tail).freeze
VERBS      = %w(spins bites licks hurdles).freeze
ADVERBS    = %w(easily lazily noisly excitedly).freeze

File.open('madlibs.txt') do |file|
  file.each do |line|
    puts format(line, noun:      NOUNS.sample,
                      verb:      VERBS.sample,
                      adjective: ADJECTIVES.sample,
                      adverb:    ADVERBS.sample)
  end
end

Discussion

Most of the work with solving this problem comes from having to
determine the way we structure our input file. We have opted to
use a really neat feature of Kernel#format; this method lets you
put strings of the form %{name} inside your format string, and then
provide a bunch of keyword arguments. Each of the keyword arguments
is matched to one of the %{name} strings, and if the name matches,
the value associated with that name is plugged in.

Our main loop does this for each line we read from madlibs.txt; each
of the special placeholders %{noun}, %{verb}, etc. is associated with
a randomly generated word of the proper type, and then format uses
those values to replace each of the placeholders. With each new line,
we get a new set of random words, so every line is treated differently.

The main loop uses the madlibs.txt file as the text data source.

Note that the format placeholders use %{name}, not #{name}: the latter
is interpolation, which differs from the type of substitution performed
by format.
=end
