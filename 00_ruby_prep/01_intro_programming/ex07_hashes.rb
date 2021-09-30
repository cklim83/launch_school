=begin

1) Given a hash of family members, with keys as the title and an array of 
names as the values, use Ruby's built-in select method to gather only 
immediate family members' names into a new array.

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
          
=end

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
          
immediate_family = family.select { |relation, names| relation == :brothers || relation == :sisters }
immediate_family_names = []
immediate_family.each_value do |names|
  immediate_family_names << names
end

immediate_family_names = immediate_family_names.flatten
p immediate_family_names
p immediate_family.values.flatten


=begin

2) Look at Ruby's merge method. Notice that it has two versions. 
What is the difference between merge and merge!? Write a program 
that uses both and illustrate the differences.

=end

# Both version combines two hashes. Merge returns a new hash containing 
# key-value pairs of the two hashes. Merge! inserts key-value pairs of 
# the second hash into the calling hash and permanently modifies it.

hash_one = { name: "David", age: 20 }
hash_two = { gender: "M", height: 178 }

p hash_one.merge(hash_two)
p hash_one
p hash_two

p hash_one.merge!(hash_two)
p hash_one
p hash_two


=begin

3) Using some of Ruby's built-in Hash methods, write a program that 
loops through a hash and prints all of the keys. Then write a program 
that does the same thing except printing the values. Finally, write a 
program that prints both.

=end

hash = { 
  name: "David", 
  age: 20, 
  gender: "M", 
  height: 178 
}

hash.each_key { |k| puts k }
hash.each_value { |v| puts v }
hash.each { |k, v| puts "#{k}: #{v}" }


=begin

4) Given the following expression, how would you access the name of the person?

person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}

=end

person = {name: 'Bob', occupation: 'web developer', hobbies: 'painting'}
puts person[:name]


=begin

5) What method could you use to find out if a Hash contains a specific value in it? 
Write a program that verifies that the value is within the hash.

=end

family = {  uncles: ["bob", "joe", "steve"],
            sisters: ["jane", "jill", "beth"],
            brothers: ["frank","rob","david"],
            aunts: ["mary","sally","susan"]
          }
puts family.value?(["bob", "joe", "steve"])


=begin

6) Given the following code...

x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}

What's the difference between the two hashes that were created?

=end

# They have different keys. my_hash has symbol key :x while my_hash2 has a string key "hi there"

x = "hi there"
my_hash = {x: "some value"}
my_hash2 = {x => "some value"}


=begin

7) If you see this error, what do you suspect is the most likely problem?

NoMethodError: undefined method `keys' for Array

A. We're missing keys in an array variable.

B. There is no method called keys for Array objects.

C. keys is an Array object, but it hasn't been defined yet.

D. There's an array of strings, and we're trying to get the string keys out of the array, but it doesn't exist.

Answer: B

=end