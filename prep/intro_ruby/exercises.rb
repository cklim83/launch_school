#1. Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], and print out each value.

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each { |i| puts i }


#2. Same as above, but only print out values greater than 5.
arr.each do |num|
  if num > 5
    puts num
  end 
end

arr.each { |num| puts num if num>5 }

#3. Now, using the same array from #2, use the select method to extract all odd numbers into a new array.
odd_arr = arr.select { |num| num.odd? }
p odd_arr


#4. Append 11 to the end of the original array. Prepend 0 to the beginning.

# Append
arr << 11  # arr.push(11)

# Prepend
arr.unshift(0)
p arr


#5. Get rid of 11. And append a 3.

arr.pop # remove last item 11
arr.push(3)
p arr


#6. Get rid of duplicates without specifically removing any one value.
p arr.uniq  # remove duplicates and return new array


#7. What's the major difference between an Array and a Hash?
# My Answer: An Array is a ordered collection of items referenced by index while a Hash is an associative data structure consisting of key and value pairs.
# Given Answer: The major difference between an array and a hash is that a hash contains a key value pair for referencing by key.


#8. Create a Hash, with one key-value pair, using both Ruby syntax styles.
person = { name: "Tom" }      # New syntax
person = { :name => "Tom" }   # Old syntax
person = { "name" => "Tom" }  # Note the key here becomes a string "name" rather than symbol :name. They are not equal


=begin
9. Suppose you have a hash h = {a:1, b:2, c:3, d:4}

1. Get the value of key `:b`.

2. Add to this hash the key:value pair `{e:5}`

3. Remove all key:value pairs whose value is less than 3.5
=end

h = {a:1, b:2, c:3, d:4}
p h[:b]

h[:e] = 5
p h

h.each do |key, value|
  if value < 3.5
    h.delete(key)
  end
end

p h

# Answer: h.delete_if { |k, v| v < 3.5 }



=begin

10. Can hash values be arrays? Can you have an array of hashes? (give examples)
My Answer: Yes. Hash value can be arrays or any type (e.g. hash, int, float, array, string). We can have array of hashes. e.g. arr = [{a:5, b:4}, {age: "27"}]

Given Answer: Yes 
# hash values as arrays.    
hash = {names: ['bob', 'joe', 'susan']}

# array of hashes
arr = [{name: 'bob'}, {name: 'joe'}, {name: 'susan'}]

=end


=begin
Given the following data structures. Write a program that copies the information from the array into the empty hash that applies to the correct person.

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# Expected output:
#  {
#    "Joe Smith"=>{:email=>"joe@email.com", :address=>"123 Main st.", :phone=>"555-123-4567"},
#    "Sally Johnson"=>{:email=>"sally@email.com", :address=>"404 Not Found Dr.",  :phone=>"123-234-3454"}
#  }
=end

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"], ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts.each_key do |key|
  hash = contacts[key]
  first_name = key.split(" ").first
  contact_data.each do |details|
    if /#{first_name}/i =~ details[0]  # using # to interpolate, i for case insensitive match.
      hash[:email] = details[0]
      hash[:address] = details[1]
      hash[:phone] = details[2]
    else
      puts "Not match, do nothing"
    end
  end
end

p contacts


#12. Using the hash you created from the previous exercise, demonstrate how you would access Joe's email and Sally's phone number?
puts "Joe's email is: #{contacts["Joe Smith"][:email]}"
puts "Sally's phone number is: #{contacts["Sally Johnson"][:phone]}"


=begin
13. Use Ruby's Array method delete_if and String method start_with? to delete all of the words that begin with an "s" in the following array.
arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

Then recreate the arr and get rid of all of the words that start with "s" or starts with "w".
=end

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
p arr.delete_if { |word| word.start_with?("s") }  # delete_if is destructive

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']
p arr.delete_if { |word| word.start_with?("s", "w") }


=begin
14. Take the following array:

a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

and turn it into a new array that consists of strings containing one word. (ex. ["white snow", etc...] 
→ ["white", "snow", etc...]. Look into using Array's map and flatten methods, as well as String's split method.
=end

a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

new_a = a.map { |phrase| phrase.split(" ") }
p new_a.flatten!


=begin
15. What will the following program output?

hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end

My Answer: It will output "These hashes are the same" since the order of keys in hashes does not matter

=end


=begin
16. Challenge: In exercise 11, we manually set the contacts hash values one by one. Now, programmatically loop or 
iterate over the contacts hash from exercise 11, and populate the associated data from the contact_data array. 
Hint: you will probably need to iterate over ([:email, :address, :phone]), and some helpful methods might be the 
Array shift and first methods.

Note that this exercise is only concerned with dealing with 1 entry in the contacts hash, like this:

contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}

As a bonus, see if you can figure out how to make it work with multiple entries in the contacts hash.
=end
p "Single Contact"
contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}
fields = [:email, :address, :phone]

contacts.each do |person, hash|
  fields.each do |field|
    hash[field] = contact_data.shift
  end
end

p contacts

p "Multiple Contacts"
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = [:email, :address, :phone]

contacts.each_with_index do |(person, hash), idx|
  fields.each do |field|
    hash[field] = contact_data[idx].shift
  end
end

p contacts
