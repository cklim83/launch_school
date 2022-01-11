=begin
1) Write a regex that matches any sequence of three characters delimited 
by whitespace characters. Test it with these strings:

reds and blues
the lazy cat sleeps

There should be three matches.

My answer:
/\s...\s/

Solution

/\s...\s/

As expected, this regex matches and and cat, together with the spaces to either
side of those words. What might be more surprising is that the also matches on
Rubular; here, the newline between the first and second lines of text is a
whitespace character.
=end


=begin
2) Test the pattern /\s...\s/ from the previous exercise against this text
(be sure to delete the previous text first):

Doc in a big red box.
Hup! 2 3 4

Observe that one of the three-letter words in this text match the pattern;
it also matches 2 3. Why is it that this pattern doesn't include the
three-letter words Doc, red, box, or Hup, but it does match 2 3?

My answer:
Only 'red' and '2 3' matchs /\s...\s/ in Rubular. 

- Doc is not matched because it does not have a leading space
- red is not match to my suprise. However it could be that its leading space
  is already used by ' big ' in that match and cannot be reused. Hence 'red' 
  is treated as if it does not have a leading space and won't match
- box does not have a trailing space hence it didnt match
- Hup have neither leading nor trailing spaces and hence didnt match
- '2 3' matches because it has leading and trailing spaces. Also 2 3 matches
  the ... specified by regex.


Solution

Note that in all of these cases, the "match" is five characters long:

    - Doc doesn't match since Doc doesn't follow any whitespace.
    - big matches since it is three characters with both leading and trailing whitespace.
    - red doesn't match since the regex engine consumes the space character that precedes
      red when it matches big (note the trailing space). Once consumed as part of a match,
      the character is no longer available for subsequent matches. (IMPORTANT)
    - box doesn't match since a period follows it.
    - Hup doesn't match since an exclamation point follows it.
    - 2 3 matches since 2 3 is three characters long and it has both leading and trailing
      whitespace.

TO REVIEW
- red is not matched to /\s...\s/ because  ' big ' preceding consumes the space in its match
   and cause red to have no leading space for the match
- ' 2 3 ' may be an unintended match
- Hup! actually have a leading space since it is on the second line, meaning a \n precedes it,
  which fulfills the leading \s. The reason it didnt match is because it had ! instead of a
  trailing whitespace
=end


=begin
3) Write a regex that matches any four digit hexadecimal number that is both preceded and
followed by whitespace. Note that 0x1234 is not a hexadecimal number in this exercise:
there is no space before the number 1234.

Hello 4567 bye CDEF - cdef
0x1234 0x5678 0xABCD
1F8A done

There should be four matches (2 on Scriptular)

My answer:
/\s\h\h\h\h\s/

Solution
/\s\h\h\h\h\s/


The real surprise here may be that cdef and 1F8A are matches. If you followed the previous
exercise, though, it shouldn't come as a surprise; cdef has a trailing white space character
in the form of a newline, and 1F8A has a preceding white space that is a newline.

Note that the JavaScript solution cannot use \h, but needs to use [\dA-F] instead, or,
equivalently, [0-9A-F].

The matches are 4567, CDEF, cdef, and 1F8A. On Scriptular, those last two numbers fail to match.


TO REVIEW
- cdef actually matches as it has a trailing \n which matches whitespace
- Similar 1F8A matches too as it has an unused leading \n.

Hello 4567 bye CDEF - cdef
0x1234 0x5678 0xABCD
1F8A done
=end


=begin
4) Write a regex that matches any sequence of three letters. Test it with these strings:

The red d0g chases the b1ack cat.
a_b c_d

There should be seven matches.

My answer:
/[a-z][a-z][a-z]/i

Solution
/[a-z][a-z][a-z]/i

This question was tricky in that it doesn't use any character class shortcuts;
recall that there isn't one for letters. Note that /\w/ matches digits and underscores as well.

If you entered something different, check your work: Rubular should highlight The, red,
cha, ses, the, ack, and cat if your regex is correct. Note in particular that neither d0g
(dee-zero-gee) nor b1a (bee-one-ay) light up, nor do either of the underscored values.


TO REVIEW
- \w matches letters, _ and 0-9, there isnt a shortcut only for letters
=end
