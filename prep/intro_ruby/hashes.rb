# Given a hash of family members, with keys as the title and an array of names as the values, use Ruby's built-in select method
# to gather only immediate family members' names into a new array.

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }

immediate_family = family.select { |key, value| key == :brothers || key == :sisters }  # select subset of family
p immediate_family.values.flatten  # get names in the form of nested array, then flatten them



# Look at Ruby's merge method. Notice that it has two versions. What is the difference between merge and merge!? 
# Write a program that uses both and illustrate the differences.

# Non destructive merge, new hash return. caller not altered
actors = { actor1: "Mary", actor2: "John" }
budget = { wages: 200000, miscellaneous: 50000 }
actors_budget = actors.merge(budget)
p "Using Merge"
p "Actors: #{actors}"
p "Budget: #{budget}"
p "Merge: #{actors_budget}"
p "Post Merge Actors: #{actors}"


# Destructive merge! will modify caller
p "Using Merge!"
p "Actors: #{actors}"
actors_budget = actors.merge!(budget)
p "Merge: #{actors_budget}"
p "Post Merge Actors: #{actors}"
puts ""



# Using some of Ruby's built-in Hash methods, write a program that loops through a hash and prints all of the keys. 
# Then write a program that does the same thing except printing the values. Finally, write a program that prints both.
puts "Keys"
family.each_key { |relations| puts relations }
puts ""

puts "Values"
family.each_value { |names| puts names }
puts ""

puts "Key and Values"
family.each do |relations, names|
  puts "#{relations}: #{names}"
end

puts ""


# Given the following expression, how would you access the name of the person?
person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
puts person[:name]


# What method could you use to find out if a Hash contains a specific value in it? Write a program to demonstrate this use.

# Answer : has_value?
if person.has_value?('Bob')
  puts "Bob is present in hash"
else
  puts "Bob is not in hash"
end


=begin
# Given the following code...

x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}

What's the difference between the two hashes that were created?

Answer:
my_hash uses the :x symbol as the key. my_hash2 uses the string "hi there" stored in x as the key.

=end



=begin
If you see this error, what do you suspect is the most likely problem?

NoMethodError: undefined method `keys' for Array

A. We're missing keys in an array variable.

B. There is no method called keys for Array objects.

C. keys is an Array object, but it hasn't been defined yet.

D. There's an array of strings, and we're trying to get the string keys out of the array, but it doesn't exist.

Answer: B. We are using a key method on an Array object

=end


=begin
Challenge: Given the array...

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

Write a program that prints out groups of words that are anagrams. Anagrams are words that have the same exact letters in them but in a different order. Your output should look something like this:

["demo", "dome", "mode"]
["neon", "none"]
(etc)
=end

words =  ['demo', 'none', 'tied', 'evil', 'dome', 'mode', 'live',
          'fowl', 'veil', 'wolf', 'diet', 'vile', 'edit', 'tide',
          'flow', 'neon']

result = {}

words.each do |word|
  key = word.split("").sort.join
  if result.has_key?(key)
    result[key].push(word)
  else
    result[key] = [word]
  end
end

result.each_value { |anagrams| p anagrams }