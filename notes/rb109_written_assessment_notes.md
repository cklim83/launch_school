Topic: RB109 Written Assessment Preparation\
Date: 14 Dec 2021\
Course: RB109

---

### Sections
[Variable Scoping Rules](#local-variable-scope-rules-in-ruby)\
[Method Definition & Method Invocation](#method-definition-and-method-invocation)\
[Mutating vs Non-Mutating Methods](#mutating-vs-non-mutating-methods)\
[Pass by Value vs Pass by Reference](#pass-by-value-vs-pass-by-reference)\
[Implicit Return Value of Method Invocations, Blocks and Puts](#implicit-return-value-of-method-invocations-blocks-and-puts)\
[Truthiness](#truthiness)\
[each, map, select](#collection-methods-each-map-select)\
[Array Sorting](#array-sorting)\
[Summary Table of Common Collection Methods](#summary-table-of-common-collection-methods)\
[Dup, Clone and Freezing](#dup-clone-and-freezing)\
[Tips & Practice Examples](#tips-and-practice-examples)

---

### Local Variable Scope Rules in Ruby
- Local variables initialized **outside** of a block is **accessible inside** a block following a method invocation
- Local variables initialized **within** a block has an **inner scope** and is **not accessible** outside that block
- A block parameter sharing **same name** as an local variable initialized outside the block will **prevent** the **outer scoped variable** from being **accessed inside** the block in a phenomenon called **Variable Shadowing**
- Inner and outer scopes are **relative** in nature and also apply to multi-level nested constructs
- Method definitions create their own scope: local variable **initialized outside** of a method definition is **not accessible inside** the method unless it is passed in as an argument

[Back to top](#sections)

---

### Method Definition and Method Invocation
- **Method definition** refers to the implementation of a Ruby method using the `def` keyword. It sets the scope for local variables and how it interacts with blocks. 
- **Method invocation** refers to the calling and execution of code defined within a method definition. It uses the scope set by method definition. 
- Methods can be called with a block, with the block acting as an argument to the method
- Method definition determines **whether and how** an argument (parameter or block) **is used**
	- Method parameter **not used**
	```Ruby
	def greetings(str)
	  puts "Goodbye"
	end
	
	word = "Hello"
	greetings(word)
	
	# Output "Goodbye"
	```
	
	- Method parameter **used**
	```Ruby
	def greetings(str)
	  puts str
	  puts "Goodbye"
	end
	
	word = "Hello"
	greetings(word)
	
	# Output "Hello"
	# Output "Goodbye"
	```
	
	- Block **not executed**
	```Ruby
	def greetings
 	  puts "Goodbye"
    end

    word = "Hello"
    greetings do  # method invocation with block
	  puts word
    end

    # Outputs 'Goodbye'
	```
	
	- Block **executed**
	```Ruby
	def greetings
	  yield
	  puts "Goodbye"
	end
	
	word = "Hello"
	greetings do
	  puts word
	end
	
	# Output "Hello"
	# Output "Goodbye"
	```
	- The `yield` keyword pass control from the method to the block. 
	- When the block returns a value, execution resume after the yield keyword in the method.
	- In the above example, a single `yield` statement in the second example result in the block executing once. Since the block has access to the local variable `word`, we output `Hello` when the block is executed.
	
- Block passed to a method invocation can help the method access outer scoped local variables that are otherwise inaccessible. Some methods also make use of the block return value to perform certain actions
```Ruby
a = "hello"

[1, 2, 3].map { |_| a } # => ["hello", "hello", "hello"]
```

The `Array#map` method is defined in such a way that it uses the return value of the block to perform transformation on each element in an array. In the above example, the `#map` method doesn't have direct access to the `a` variable. However, the block that we pass to `map` (and that `map` calls) does have access to `a`. Thus, the block can use the value of `a` to determine the transformation value for each array element

[Back to top](#sections)

---

### Mutating vs Non-Mutating Methods
- Mutating methods are those that change the value (state) of objects. A method may be mutating **with respect to** the caller and/or its arguments.

- In Ruby, there is a convention for names of mutating methods to end with `!`. However, there are exceptions: e.g. `#<<`, `#[]=` (index assignment), `something=` (setter methods) and `delete` are mutating but does not end with `!`

- Non-mutating methods do not change the state of objects. Assignment `=` or assignment operators `+=, -=, *= or /=` do not mutate the object a variable is currently referencing. They merely reassign it to a new object. 
	
	```Ruby
	a = "hello"		# => "hello"
	a.object_id		# => 1900238400
	a += " world"	# => "hello world"
	a.object_id		# => 1900239600
	```
	`a += ' world'` is syntactical sugar for `a = a.+(' world')` i.e. `a` referencing `"hello"` calling `String#+` method and passing `" world"` which returns a **new string** with value `"hello world"` which is then **reassigned** to `a`. We can see this from the change in object_id following reassignment. The original `hello` string is not mutated.

- **Element reference** methods `String#[index]`, `Array#[index]` and `Hash#[key]` are also **non-mutating**. **`String#[index]`** returns a **new character** with the same value as the object at that index while `Array#[index]` or `Hash#[key]` returns the actual element at the index/key.
	
	- Note: A `String` object is different to collection (`Array` or `Hash`) objects: a `String` is represented as a **single object** and **not a an object with objects within** like `Array` or `Hash`. This difference manifest when we call `String#[index]` or `String#each_char` as the method would create and return a **new String object** with the same value as the character at the given index in the original String. `Array#[index]` or `Hash#[index]` on the other hand would just retrieve and return the **actual component object**. This can be verified with `String#[index].object_id`, which returns **a different unique id** each time its called on the same String object, despite them all having the same values.
	
	- This distinction is important because **calling `String#[index].upcase!` will not mutate the original String object** but `Array#[index].upcase!` would.
	
	- The distinction disappears once we call the `String#slice or Array#slice` method using the `String/Array#[start, length]` or `String/Array#[range]` syntax.  **Both** String and Array will return a **new object**

[Back to top](#sections)

---

### Pass by Value vs Pass by Reference
- **Pass by value** involves passing a copy of an object as an argument to a method call. Since the original object is not passed into the method call, the original object CANNOT be mutated by the method.
- **Pass by reference** involves passing a reference to the original object to the method call. The local variable within the method receiving the reference will then have the ability to access and mutate the original object. Original objects mutated during the method call will retain the new value post method call.
- Ruby is a pass by reference programming language. Since Ruby variables are merely labelled references (pointers) to objects, a copy of the reference to an object is passed as an argument during a method call. This meant the method cannot alter the reference of the original argument (thus pass by reference value is a more precise description of how Ruby pass objects during method calls).
	- If the method scoped local variable (parameter) mutates the actual object using the passed reference (assuming said object is mutable), the original argument will also be affected and the method is deemed mutating. 
	- If however, we are just reassigning the method scoped local variable (parameter) to a new object, the original argument will not be changed and the method will be deemed non-mutating. 

[Back to top](#sections)

---

### Implicit Return Value of Method Invocations, Blocks and Puts
- Ruby methods will return the **value of the last evaluated expression** unless an explicit `return` expression is executed
- Ruby blocks will return the **value of the last evaluated expression**
- A `return` reserved word is **not** required to return a value from a method/block
- `puts` converts its argument into a String by calling `#to_s` before it outputs the result and return `nil`

[Back to top](#sections)

---

### Truthiness
-   Only `false` or `nil` are `falsey`. All other values are `truthy`
-   A `truthy` value is not the same as `true`. For example `hello` is `truthy` but is not equal to `true`. Likewise `nil` is `falsey` but is not `false` 
-   Summary:
	-   Use `evaluates to true`, `evaluates as true` or `is truthy` when discussing an expression that evaluates as true in a boolean context
	-   Do not use `is true` or `is equal to true` unless specifically discussing the boolean `true`
	-   Use `evaluates to false`, `evaluates as false`, `is falsey` when discussing an expression that evaluates as false in a boolean context
	-   Do not use `is false` or `is equal to false` unless specifically discussing the boolean `false`
	
	**Example**
	```Ruby
	a = "Hello"
	
	if a 
	  puts "Hello is truthy"
	else
	  puts "Hello is falsey"
	end
	```
	- Incorrect explantion
		- `a` is `true` and so 'Hello is truthy' is the output
		- `a` is equal to `true` and so 'Hello is truthy' is the output
	- Correct explanation
		- `a` evaluates as `true` in the conditional statement and so 'Hello is truthy' is output OR
		- `a` is `truthy` and so 'Hello is truthy' is output

[Back to top](#sections)

---

### Collection Methods (each, map, select)
- `each` method **iterates through each element** in the caller object. In each iteration, it passes the current element to a block parameter for block execution. The block executes and returns the value of the last evaluated statement in the block back to `each`, which **ignores these return values** and **return the original caller**
- `map` method **iterates through each element** in the caller object. In each iteration, it passes the current element to a block parameter for block execution. The block executes and the **last evaluated statement in the block will return a value** (one for each element) back to `map`, which then **use these return objects as elements of a new array** to be returned by `map`
- `select` method **iterates through each element** in the caller object. In each iteration, it passes the current element to the block parameter for block execution. The block executes and the **last evaluated statement in the block will return a value** (one for each element) back to `select`. `select` will create a **new container object** (array/hash depending on caller) and only **include elements from the calling collection whose block return value evaluates to `true`**.
```Ruby
a = ["hello", "bye"]
a.object_id			# => 70216084941460
a[0].object_id		# => 70216084941500
a[1].object_id		# => 70216084941480

b = a.select { |word| word.length > 3 }
b					# => ["hello"]
b.object_id			# => 70216088501460, different from a
b[0].object_id		# => 70216084941500, same as a[0] object_id
```

[Back to top](#sections)

---

### Array Sorting
- To sort a collection, we have to **compare objects** to establish their relative positions

- The `<=>` method (aka spaceship operator) is used to compare two objects. `a <=> b` is actually a method call `a.<=>(b)`. The method should return one of the following values:
	- `-1` when caller is smaller than argument
	- `0` when caller is equal to argument
	- `1` when caller is greater than argument
	- `nil` when caller cannot be compared to argument
	```Ruby
	2 <=> 1		# => 1 
	1 <=> 2		# => -1
	2 <=> 2		# => 0
	'b' <=> 'a' # => 1
	'a' <=> 'b'	# => -1, caller is 
	'b' <=> 'b'	# => 0, equal
	1 <=> 'a'	# => nil, not comparable
	```

- When an array object calls `sort`, the sort algorithm iterate through the element objects which call the `<=>` method for their object type and use the return values to order the items. If `nil` is returned in any comparison, an `ArgumentError` is thrown
	```Ruby
	['a', 1].sort # => ArgumentError: comparison of String with 1 failed
	```

- Hence, before sorting a collection, we need to know
	1. If its elements has a `<=>` method? and
	2. How is the `<=>` method implemented? For example `String#<=>` is implemented differently from `Integer#<=>`

#### The `sort` method
- When we call sort on an array, it returns a **new array** of ordered items
- `sort` can be called with a block to control how items are sorted (e.g. ascending vs descending). The block shall accept **two** block parameters, and **need to return `-1, 0, 1 or nil`**
	```Ruby
	[2, 5, 3, 4, 1].sort do |a, b|
	  ... 		# Optional additional code, e.g output
	  a <=> b	# block return value
	end
	# => [1, 2, 3, 4, 5]

	[2, 5, 3, 4, 1].sort do |a, b|
	  ...		# optional additional code
	  b <=> a	# switching comparison order result in descending order
	end
	# => [5, 4, 3, 2, 1]
	```

##### `String#<=>`
- String objects are compared **character by character**
	- If both strings have the same character at index 0, the next character of each string is compared until the return value `-1, 0, 1 or nil` is established
	- If comparable characters are all equal, the shorter string is deemed smaller. e.g. `cap` <=> `cape` returns `-1`
- The order of a character is determined by its position in the [ASCII table](https://en.wikipedia.org/wiki/ASCII#Code_chart) which we can use `String#ord` to retrieve. In general:
	- Uppercase letters comes before lowercase letters
	- Digits and (most) punctuations come before letters
	- Accented and other characters are in extended ASCII table that comes after main ASCII table
	
	```Ruby
	'A'.ord		# => 65
	'a'.ord		# => 97
	'9'.ord		# => 57
	
	'A' <=> 'a'	# => -1
	'A' <=> '9'	# => 1
	```

##### `Symbol#<=>`
 - `Symbol#<=>` is essentially `String#<=>` since it first call `Symbol#to_s` on each symbol to convert it to string first before the `<=>` comparison

##### `Array#<=>` 
- Arrays are also compared in an **element-wise** manner: 
	- We start by comparing the first object in each array. We move on to the next object until the return value (`-1, 0, 1 or nil`) is established
	- If two arrays are exactly equal when all the comparable elements are exhausted, the shorter array is deemed smaller e.g. `['a', 'car', 'd', 3]` <=> `['a', 'car', 'd']` will return `1` and not generate an `ArgumentError` since the different array lengths ensure there is no comparison between `3` and another object type.

- Comparison between non-comparable elements need not necessarily raise an `ArgumentError` if that comparison is not necessary
 
	```Ruby
	[['a', 'cat', 'b', 'c'], ['b', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort

	# => [["a", "car", "d"], ["a", "car", "d", 3], ["a", "cat", "b", "c"], ["b", 2]]
	```
	- After comparing the first element of subarrays, the final order of `['b', 2]` is already clear since `'b'` is bigger than `'a'`, the first element in all other subarrays 
	
	- As such, `["b", 2]` did not participate in the second element comparison, avoiding a string and integer comparison, which will return `nil` and raise an `ArgumentError`
	
	- If we have `["a", 2]` instead of `["b", 2]`, ArgumentError would have been raised when we compare the second element of each subarray since the position of `["a", 2]` is not clear after the first element comparison and the comparison between string and integer would have occurred
		```ruby
		[['a', 'cat', 'b', 'c'], ['a', 2], ['a', 'car', 'd', 3], ['a', 'car', 'd']].sort
		# => ArgumentError: comparison of Array with Array failed
		```


#### The `sort_by` Method
- `sort_by` is similar to `sort`, except that it is usually called with a block. The return value of the block is used by sort_by to order the elements
	```Ruby
	['cot', 'bed', 'mat'].sort_by do |word|
	  word[1]	# sort by 2nd character only
	end
	# => ["mat", "bed", "cot"]
	```

- When we call `sort_by` on a **hash**, **two arguments** representing key and value are passed to the block. `sort_by` **always returns an Array**

	**Using Integer#<=>**
	```Ruby
	people = { Kate: 27, john: 25, Mike: 18 }
	people.sort_by do |_, age|
	  age
	end
	# => [[:Mike, 18], [:john, 25], [:Kate, 27]]
	```

	**Using Symbol#<=> (Equivalent to String#<=>)**
	```Ruby
	people = { Kate: 27, john: 25, Mike: 18 }
	people.sort_by do |name, _|
	  name.capitalize 	# so that 'j' comes before 'K'
	end
	# => [[:john, 25], [:Kate, 27], [:Mike, 18]]
	```
 
 [Back to top](#sections)
 
 ---
 
### Summary Table of Common Collection Methods
|Class/Module| each | select | map | sort|
|---|---|---|---|---|
|String|`#each_char`||||
| Array | `#each` | `#select`, `#select!` | `#map`, `#map!` | `sort`, `sort!`, `sort_by!`|
| Hash | `#each` | `#select`, `#select!` |  |  |
| Enumerable |  | `#select` | `#map` | `sort`, `sort_by` |

[Back to top](#sections)

---

### Dup, Clone and Freezing
#### Dup and Clone
- `dup` and `clone` are Ruby methods to create a **shallow copy** of an object: only the object calling the method is copied. Objects **within** it are **shared, not copied**

	```Ruby
	arr1 = ["a", "b", "c"]
	arr2 = arr1.dup
	arr2[1].upcase!

	arr2	# => ["a", "B", "c"]
	arr1	# => ["a", "B", "c"]
	```

- We need to draw distinction whether mutation is at **array or element level**	
	
	**Mutation at Array Level**
	```Ruby
	arr1 = ["a", "b", "c"]
	arr2 = arr1.dup
	arr2.map! do |char|
	  char.upcase
	end

	arr1	# => ["a", "b", "c"]
	arr2	# => ["A", "B", "C"]
	```
	`arr2` is mutated but `arr1` is not. This is because the array copy referenced by `arr2` is mutated by the destructive `Array#map!`, with `arr2` containing new string objects returned by `char.upcase`. Since original elements of `arr2` are not mutated by `String#upcase`, `arr1` is left unchanged. 

	**Mutation at Element Level**
	```Ruby
	arr1 = ["a", "b", "c"]
	arr2 = arr1.dup
	arr2.each do |char|
  	  char.upcase!
	end

	arr1 # => ["A", "B", "C"]
	arr2 # => ["A", "B", "C"]
	```
	Following `arr2 = arr1.dup`, `arr2` is assigned a new array object that contain the **same string elements** as `arr1` as `dup` produces a **shallow copy**. Thus, when we **destructively mutate** each element in the array referenced by `arr2` using `#upcase!`, `arr1` is also affected

#### Freezing Objects
- Ruby objects can be frozen to prevent their state from being modified.
- `clone` will **preserve the frozen state** of an object while `dup` does not. Any attempts to change a clone will raise a `RuntimeError`
	```ruby
	arr1 = ["a", "b", "c"].freeze
	arr2 = arr1.clone
	arr2 << "d"
	# => RuntimeError: can't modify frozen Array
	```

	```ruby
	arr1 = ["a", "b", "c"].freeze
	arr2 = arr1.dup
	arr2 << "d"

	arr2 # => ["a", "b", "c", "d"]
	arr1 # => ["a", "b", "c"]
	```
- Only mutable objects can be frozen since immutable objects are by default already frozen
- We can check if an object is already frozen with `#frozen?`
	```ruby
	5.frozen? # => true
	```

- `freeze` only freezes the object it is called on. If there are nested objects within it, those will not be frozen.
	```ruby
	arr = [[1], [2], [3]].freeze
	arr[2] << 4
	arr # => [[1], [2], [3, 4]]
	
	arr << 10	# => FrozenError, cant modify frozen Array
	```

[Back to top](#sections)

---

### Tips and Practice Examples
#### Tips
- Learn the correct terminology
	```Ruby
	[false, false, false].select { |num| 100 }
	# => [false, false, false]
	```
	- Common errors:
		- When the element is `falsey`, it is not selected (It is not about the truthiness of element but that of the return value of block)
		- When the block returns `true` (The return value of the block may be truthy but not `true` and the element will still get included)
		- When the block is truthy (We are talking about truthiness of the return value of the block, not the block itself)

	```Ruby
	def test(str)
  	  str += '!!!'
  	  str.upcase!
	end

	test_str = "Something"
	test(test_str)

	puts test_str
	```
	- Common errors:
		- `str` variable is mutated (wrong because variables do not get mutated, it is the object being referenced that gets mutated)
		- we call method `upcase!` on `str` (wrong because we can't call methods on variables)
	
- Be precise. Do not approach each question by describing what each line of the code does. Start at execution points e.g. method invocation, then the arguments passed, and relevant lines in method definition that resulted in observed output
	
	```Ruby
	def test(str)
  	  str += '!!!'
  	  str.upcase!
	end

	test_str = "Something"
	test(test_str)

	puts test_str
	```
	- Key points:
		- `test_str` was initialized with string `"Something"` on line 6
		- We invoke the method `test` and pass `test_str` in as an argument
		- `str` and `test_str` now reference same string `"Something"`
		- `str += '!!!'` caused `str` to be **reassigned** to **new string** `"Something!!!"`
		- `str` and `test_str` are pointing to different objects and `test` can no longer mutate the object referenced by `test_str`. Hence `puts test_str` outputs `"Something"``

#### Local Variable Scope
```Ruby
greeting = 'Hello'

loop do
  greeting = 'Hi'
  break
end

puts greeting
```
Examine the code example above. The last line outputs the String `Hi` rather than the String `Hello`. Explain what is happening here and identify the underlying principle that this demonstrates. <br>

On line 1, local variable `greeting` was **initialized** to the String `Hello`. The **`do..end`** that follows the `loop` method invocation on lines 3-6 **defines a block**. Since local variables initialized outside a block can be accessed within the block, `greeting` was able to be **reassigned** to another String `Hi` on line 4. On line 8, the **`puts` method was called** with local variable **`greeting` passed as an argument**. Since `greeting` is now referencing `Hi`, this is what is being **output**. This example **demonstrates local variable scoping rules in Ruby: local variables initialized outside of a block is accessible inside the block**.

#### Map
```Ruby
[[1, 2], [3, 4]].map { |arr| puts arr[0] }
```
Explain the output and return value of above code example <br>

1
3
=> [nil, nil]
We have a multi-dimensional array calling the method `map` with a block having `arr` as parameter. `map` iterates through each element in the caller, and assign it to `arr` for block execution. In each iteration `puts arr[0]` **outputs** the first element and returns `nil` which is also the **return value** of the block and **used as elements in a new array** to be returned by `map`

In 1st iteration, `arr` is assigned to subarray `[1, 2]` and `puts arr[0]` output `1` and returns `nil`
In 2nd iteration, `arr` is assigned to subarray `[3, 4]` and `puts arr[0]` output `3` and returns `nil`
`map` then include both block return values in new array to return `[nil, nil]`

```Ruby
['ant', 'bear'].map do |elem|
  if elem.length > 3
    elem
  end
end
```

#### Mutating Collections While Iterating
```ruby
def remove_evens!(arr)
  arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end

p remove_evens!([1,1,2,3,4,6,8,9])
# expected return value [1, 1, 3, 9]
# actual return value [1, 1, 3, 6, 9]
```
The `Array#delete` method is destructive, and is changing the contents of `arr` during iteration.

One way you could fix the code above is to create a shallow copy of the array and iterate through it while mutating the original array.
```ruby
def remove_evens!(arr)
  cloned_arr = arr.dup
  cloned_arr.each do |num|
    if num % 2 == 0
      arr.delete(num)
    end
  end
  arr
end
```

#### Sorting
```ruby
arr = [['1', '8', '11'], ['2', '6', '13'], ['2', '12', '15'], ['1', '8', '9']]

arr.sort # => [["1", "8", "11"], ["1", "8", "9"], ["2", "12", "15"], ["2", "6", "13"]]
```

- sorting nested arrays which involves two sets of comparisons
	- Each of the inner arrays is compared with the other inner arrays.
	- Arrays are compared using element-wise comparison. Since the elements are Strings, we are comparing using `String#<=>`. Hence `"11"` comes before `'9'`, which explains the order of the return result.
	
- To sort by numberical comparisons, we need to convert the elements to Integers first using 	`sort_by` to tap on `Integer#<=>`
```ruby
arr.sort_by do |sub_arr|
  sub_arr.map do |num|
    num.to_i
  end
end
# => [["1", "8", "9"], ["1", "8", "11"], ["2", "6", "13"], ["2", "12", "15"]]
```

#### Template Collection Answers
We have a `object_value/type` calling the method `method_name` with a block having `param_name` as its parameter. `method_name` iterates through each element in the caller, and assigns each element to `param_name` for block execution. In each iteration, ... [output/mutate/reassign] and the block returns `...` to `method_name`. `method_name` [ignores/use ...] and returns [the original caller/new array/hash].

In 1st iteration, `param_name` is assigned to `...` and `code_segment` [output/mutate/reassign] ... and the block returns `block_return_value`

In similar fashion, subsequent iterations output ... and the block returns ... respectively
`method_name` then include these block return values in [new_array|original object] to return 

[Back to top](#sections)

