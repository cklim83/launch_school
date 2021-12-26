=begin

Group Anagrams

Given the array...

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

Write a program that prints out groups of words that are anagrams.
Anagrams are words that have the same exact letters in them but in
a different order. Your output should look something like this:

["demo", "dome", "mode"]
["neon", "none"]
#(etc)
=end

=begin
Problem
- input: array of strings
- output: output groups of anagrams (words containing same characters in 
          different orders)

Examples
- see above
- We start wih first word and find all its anagrams, then we move to the
  next ungrouped group word in the array, but strings in the same group are sorted

Data Structure
- input: array of words
- output: array of anagrams
- intermediary: array of arrays

Algorithm
1. set arr_size = arr.size 
2. available_indices = (0...arr_size).to_a
3. set groups = []
   
4.  while available_indices is not empty
      group_key = available_indices.shift
      set new_group = [arr[group_key]]
      compare_index = available_indices.first
    
5.    while compare_index is not nil
        if new_group.first.sort == arr[compare_index].sort
          available_indices.delete(compare_index)
          new_group << arr[compare_index]
        end
        compare_index = next available index greater than current compare index or nil
      end
6.    
      groups << new_group
    end
7. return groups
=end      

def group_anagrams(arr)
  groups = []
  arr_size = arr.size
  available_indices = (0...arr_size).to_a
  
  while !available_indices.empty?
    group_key_index = available_indices.shift
    new_group = [arr[group_key_index]] # assign new_group to new array
    compare_index = available_indices.first
 
    while compare_index
      if new_group.first.chars.sort == arr[compare_index].chars.sort
        available_indices.delete(compare_index)
        new_group << arr[compare_index]
      end
      
      compare_index = available_indices.select { |num| num > compare_index }.min
    end
    
    groups << new_group # append array currently pointed by new_group to groups
  end
  
  groups
end


words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']
          
p group_anagrams(words)


=begin
Solution

result = {}

words.each do |word|
  key = word.split('').sort.join
  if result.has_key?(key)
    result[key].push(word)
  else
    result[key] = [word]
  end
end

result.each_value do |v|
  puts "------"
  p v
end

Discussion

The trickiest part of this problem is figuring out how to check if two words
are anagrams. Since anagrams are two words which contain exact same letters,
but in different order, if we sort each anagram word, values should be the
same. For example:

dome and mode are anagrams because when we sort both of them we get demo.

Now that we know how to find anagrams, we can use a hash to store the sorted
version of the word as the key in the hash and its value will be an array of
all anagrams of that word.

Translating this to code...we first initialize a hash result.

Then, we iterate over the words array and in each iteration:

    We check if the sorted version of the word is already in the hash. If it
    is we add it to the value array.
    If the sorted version is not in the hash we add it to the hash and the
    initial value of that key is just the array with that word in it.

In the end we print the values in the result hash.
=end


=begin
TO REVIEW (Important example)
- Hash is a better data structure if we want to group elements with certain 
  commonality (e.g. anagrams will share same keys). The hashing function 
  (sorting each word in this example), will map each word to correct keys

=end
