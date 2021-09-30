=begin

1) Use the each method of Array to iterate over [1, 2, 3, 4, 5, 6, 7, 8, 9, 10], 
and print out each value.

=end

arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
arr.each { |num| puts num }


=begin

2) Same as above, but only print out values greater than 5.

=end

arr.each { |num| puts num if num > 5 }


=begin

3) Now, using the same array from #2, use the select method to extract 
all odd numbers into a new array.

=end

odd_arr = arr.select { |num| num%2 == 1 }
p odd_arr


=begin

4) Append 11 to the end of the original array. Prepend 0 to the beginning.

=end

arr << 11
arr.unshift(0)
p arr


=begin

5) Get rid of 11. And append a 3.

=end

arr.delete(11)
arr.push(3)
p arr


=begin

6) Get rid of duplicates without specifically removing any one value.

=end

arr.uniq!
p arr


=begin

7) What's the major difference between an Array and a Hash?

My Answer: An array is an ordered index of items while a Hash is an associative data structure of key-value pairs.

Given Answer: The major difference between an array and a hash is that a hash contains a key value pair for referencing by key.

=end


=begin

8) Create a Hash, with one key-value pair, using both Ruby syntax styles.

=end

my_hash = { movie: "spiderman" }  # Ruby 1.9 onwards
my_hash_old = { :movie => "spiderman" }  # old version before Ruby 1.9
my_hash_extra = Hash.new()  # Another method, with default value option
my_hash_extra[:movie] = "spiderman"

p my_hash
p my_hash_old
p my_hash_extra


=begin

9)Suppose you have a hash h = {a:1, b:2, c:3, d:4}

1. Get the value of key `:b`.

2. Add to this hash the key:value pair `{e:5}`

3. Remove all key:value pairs whose value is less than 3.5

=end

h = {a:1, b:2, c:3, d:4}

p h[:b]
p h.fetch(:b)

h[:e] = 5

h.delete_if { |k, v| v <3.5 }
h.select! { |k, v| v >=3.5 }
h.keep_if { |k,v| v >= 3.5 }

p h


=begin

10) Can hash values be arrays? Can you have an array of hashes? (give examples)

My Anwer: Yes, Yes. 

=end

heights_hash = { heights: [170, 185, 175] }
weights_hash = { weights: [65, 80, 70] }
my_arr = [heights_hash, weights_hash]
p heights_hash
p weights_hash
p my_arr


=begin

11) Given the following data structures, write a program that copies 
the information from the array into the empty hash that applies to the correct person.

contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

# Expected output:
#  {
#    "Joe Smith"=>{:email=>"joe@email.com", :address=>"123 Main st.", :phone=>"555-123-4567"},
#    "Sally Johnson"=>{:email=>"sally@email.com", :address=>"404 Not Found Dr.",  :phone=>"123-234-3454"}
#  }

=end

contact_data = [
  ["joe@email.com", "123 Main st.", "555-123-4567"],
  ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]
]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}


contacts["Joe Smith"][:email] = contact_data[0][0]
contacts["Joe Smith"][:address] = contact_data[0][1]
contacts["Joe Smith"][:phone] = contact_data[0][2]
contacts["Sally Johnson"][:email] = contact_data[1][0]
contacts["Sally Johnson"][:address] = contact_data[1][1]
contacts["Sally Johnson"][:phone] = contact_data[1][2]

p contacts


=begin

12) Using the hash you created from the previous exercise, 
demonstrate how you would access Joe's email and Sally's phone number.

=end

puts "Joe's email is: #{contacts["Joe Smith"][:email]}"
puts "Sally's phone number is: #{contacts["Sally Johnson"][:phone]}"


=begin

13) Use Ruby's Array method delete_if and String method start_with? 
to delete all of the strings that begin with an "s" in the following array.

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

Then recreate the arr and get rid of all of the strings that start with "s" or starts with "w".

=end

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.delete_if { |string| string.start_with?('s') }
p arr

arr = ['snow', 'winter', 'ice', 'slippery', 'salted roads', 'white trees']

arr.delete_if { |string| string.start_with?('s', 'w') }
p arr


=begin

14) Take the following array:

a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']
     
and turn it into a new array that consists of strings containing one word. 
(ex. ["white snow", etc...] → ["white", "snow", etc...]. 
Look into using Array's map and flatten methods, as well as String's split method.

=end

a = ['white snow', 'winter wonderland', 'melting ice',
     'slippery sidewalk', 'salted roads', 'white trees']

result = a.map { |phrase| phrase.split }

result.flatten!
p result


=begin

15) What will the following program output?

hash1 = {shoes: "nike", "hat" => "adidas", :hoodie => true}
hash2 = {"hat" => "adidas", :shoes => "nike", hoodie: true}

if hash1 == hash2
  puts "These hashes are the same!"
else
  puts "These hashes are not the same!"
end

# My Answer: These hashes are the same. As Hashes are unordered and both have same contents, they are the same.

=end


=begin

16) Challenge: In exercise 11, we manually set the contacts hash values one by one. Now, programmatically loop 
or iterate over the contacts hash from exercise 11, and populate the associated data from the contact_data array. 
Hint: you will probably need to iterate over ([:email, :address, :phone]), 
and some helpful methods might be the Array shift and first methods.

Note that this exercise is only concerned with dealing with 1 entry in the contacts hash, like this:

contact_data = ["joe@email.com", "123 Main st.", "555-123-4567"]
contacts = {"Joe Smith" => {}}

As a bonus, see if you can figure out how to make it work with multiple entries in the contacts hash.

=end

contact_data = [
  ["joe@email.com", "123 Main st.", "555-123-4567"],
  ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]
]

contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}

contacts.each_with_index do |(k, v), idx|
  contacts[k][:email] = contact_data[idx][0]
  contacts[k][:address] = contact_data[idx][1]
  contacts[k][:phone] = contact_data[idx][2]
end

p contacts


# Provided Answer
contact_data = [["joe@email.com", "123 Main st.", "555-123-4567"],
            ["sally@email.com", "404 Not Found Dr.", "123-234-3454"]]
contacts = {"Joe Smith" => {}, "Sally Johnson" => {}}
fields = [:email, :address, :phone]

contacts.each_with_index do |(name, hash), idx|
  fields.each do |field|
    hash[field] = contact_data[idx].shift
  end
end
