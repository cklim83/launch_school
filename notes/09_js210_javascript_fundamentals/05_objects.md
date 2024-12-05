## Section Links
[Introduction](#introduction)\
[Object Properties](#object-properties)\
[Stepping Through Object Properties](#stepping-through-object-properties)\
[Arrays and Objects](#arrays-and-objects)\
[Arrays: What is an Element?](#arrays-what-is-an-element)\
[Mutability of Values and Objects](#mutability-of-values-and-objects)\
[Pure Functions and Side Effects](#pure-functions-and-side-effects)\
[Working with the Math Object](#working-with-the-math-object)\
[Working with Dates](#working-with-dates)\
[Working with Function Arguments](#working-with-function-arguments)

---

## Introduction
JavaScript is an _object-oriented_ language; the code uses objects to organise code and data. Data values and functions that operate on those values are typically part of the same object.

### Standard Built-in Objects
`String`, `Array`, `Object`, `Math` and `Date` are some commonly used standard built-in objects in JavaScript.

Some built-in objects share the **same names** as primitive data types e.g. `String` and `Number`. While the name may be the same, objects are actually different from primitive values:

1. Methods can only be called on objects but not on primitive values.
	```javascript
	'hi'.toUpperCase();     // "HI"
	```

2. While the code snippet above suggest method calls also work for primitive string `hi`. What actually happens is that under the hood, JavaScript automatically and temporarily coerce the string primitive `hi` to its `String` object counterpart prior to the method call. This process is known as **auto-boxing**. This allow us to use primitive values as though they are objects without the need to create their object forms.

	```javascript
	let a = 'hi';                 // Create a primitive string with value "hi"
	typeof a;                     // "string"; This is a primitive string value
	
	let stringObject = new String('hi'); // Create a string object
	typeof stringObject;          // "object"; This is a String object
	
	a.toUpperCase();              // "HI" (auto-boxing takes place)
	stringObject.toUpperCase();   // "HI"
	
	typeof a;                     // "string"; The coercion is only temporary
	typeof stringObject;          // "object"
	```

3. The same is true for other primitive types except `null` or `undefined`.
	```javascript
	42.5639.toFixed(2);           // "42.56" (auto-boxing takes place)
	true.toString();              // "true" (auto-boxing takes place)
	```

### Create Custom Objects
We can use the object **literal notation** to create our own objects.
```javascript
let colors = {
  red: '#f00',
  orange: '#ff0',
};

typeof colors;      // "object"
colors.red;         // "#f00"
colors.orange;      // "#ff0"
```

We can also use an object constructor function e.g. `new String('foo')` or using the `Object.create` method to create objects.

### Properties
Object are containers for data and behaviours. The data consists of name and value pairings. These associations are known as an object's **properties**.

We use the **dot notation** to access an object property value.
```javascript
let animal = 'turtle';
animal.length;          // 6

let colors = {
  red: '#f00',
  orange: '#ff0',
};

colors.red;             // "#f00"

'blue'.length;          // 4 - works with primitives too
```

We use assignment to set a property's value.
```javascript
let count = [0, 1, 2, 3, 4];
count.length = 2;

let colors = {
  red: '#f00',
  orange: '#ff0',
};

colors.blue = '#00f';
```

### Methods
Methods are functions belonging to an object, defining its behaviors.

To call a method on an object, we use the dot notation plus parentheses. They may accept arguments like any function.
```javascript
(5.234).toString();       // "5.234"
'pizza'.match(/z/);       // [ "z", index: 2, input: "pizza" ]
Math.ceil(8.675309);      // 9
Date.now();               // 1467918983610
```

### Literal Object Style
In object literal notation, we append a **trailing comma `,` to the last property** of method of that object.
```javascript
// Property as last
let myObj = {
  prop1: 'sample data',
  method1: function () {},
  prop2: 'sample data',
};
```
```javascript
// Method as last
let myObj = {
  prop1: 'sample data',
  prop2: 'sample data',
  method1: function () {},
};
	```

The trailing comma for the last object item confers two benefits:

1. No need to add/remove comma when we reorder the object contents

2. `git diff` will register only 1 line of change when we add a new item (since there is no need to add trailing comma to the previous line).
	```javascript
	// no trailing comma
	let myObj = {
	  prop1: 'sample data',
	  prop2: 'sample data',
	  method1: function () {}
	};
	
	// adding a property
	let myObj = {
	  prop1: 'sample data',
	  prop2: 'sample data',
	  method1: function () {},  // changed
	  prop3: 'sample data'      // added
	};
	```

No trailing commas needed for one-line literals
```javascript
let coordinates = { x: 25, y: 50 };
```

### Compact Method Notation
From ES6, rather than writing a property name, a colon, then function expression, we can just do simplify it as follows:

From:
```javascript
let myObj = {
  foo: function (who) {
	console.log(`hello ${who}`);
  },

  bar: function (x, y) {
	return x + y;
  },
};
```

To:
```javascript
let myObj = {
  foo(who) {
	console.log(`hello ${who}`);
  },

  bar(x, y) {
	return x + y;
  },
};
```

### Arrow Function
DO NOT use arrow functions as methods.

### Capitalization
There is a subtle distinction between capitalized names like `String`, `Array` and `Objects` and their lowercase counterparts (string, array, object). In general, we use the capital version when:
- Talking about the **object form** of a primitive type. If we are just referring to the primitive type, use the lowercase name e.g. string, number, boolean.
- Use Object when referring to methods and properties from the `Object` class. Use `Array` to refer to methods and properties from the `Array` class. (Class is just a conceptual term here since JavaScript have no true classes). Use object to refer to objects otherwise.
- Use capitalized names for function and prototype objects. E.g. use `new Date()` instead of `new date()`.

[Back to Top](#section-links)


## Object Properties
### Property Names and Values
An object's property **name** can be any **valid string** and its **value**, any **valid expression**. 
```javascript
let object = {
  a: 1,                           // a is a string with quotes omitted
  'foo': 2 + 1,                   // property name with quotes
  'two words': 'this works too',  // a two word string
  true: true,                     // property name is implicitly converted to string "true"
  b: {                            // object as property value
    name: 'Jane',
    gender: 'female',
  },
  c: function () {                // function expression as property value
    return 2;
  },
  d() {                           // compact method syntax
    return 4;
  }
};
```

### Accessing Property Values
Access the property value using "**dot notation**" or "**bracket notation**". Use bracket notation when property name is not a valid identifier.
```javascript
let object = {
  a: 'hello',
  b: 'world',
};

object.a;                 // "hello", dot notation
object['b'];              // "world", bracket notation
object.c;                 // undefined when property is not defined

let foo = {
  a: 1,
  good: true,
  'a name': 'hello',
  person: {
    name: 'Jane',
    gender: 'female',
  },
  c: function () {        // function expression as property value
    return 2;
  },
  d() {                   // compact method syntax
    return 4;
  }
};

foo['a name'];            // "hello", use bracket notation when property name is an invalid identifier
foo['goo' + 'd'];         // true, bracket notation can take expressions
let a = 'a';
foo[a];                   // 1, bracket notation works with variables since they are expressions
foo.person.name;          // "Jane", dot notation can be chained to "dig into" nested objects
foo.c();                  // 2, Call the method 'c'
foo.d();                  // 4, Call the method 'd'
```

### Add and Update Properties
Use dot or bracket notation and assign a value for a new property
```javascript
let object = {};              // empty object

object.a = 'foo';
object.a;                     // "foo"

object['a name'] = 'hello';
object['a name'];             // "hello"

object;                       // { a: "foo", "a name": "hello" }
```

If property already exists, using assignment to update its value.
```javascript
let object = {};

object.a = 'foo';
object.a;                    // "foo"

object.a = 'hello';
object.a;                    // "hello"

object['a'] = 'world';
object.a;                    // "world"
```

Use reserve keyword `delete` to remove properties from objects.
```javascript
let foo = {
  a: 'hello',
  b: 'world',
};

delete foo.a;
foo;                      // { b: "world" }
```

[Back to Top](section-links)


## Stepping Through Object Properties
`for...in` loop can be use to iterate through the keys of an object.
```javascript
let nicknames = {
  joseph: 'Joey',
  margaret: 'Maggie',
};

for (let nick in nicknames) {
  console.log(nick);
  console.log(nicknames[nick]);
}

// logs on the console:
joseph
Joey
margaret
Maggie
```

`Object.keys` will return the names of all properties in an object as an array.
```javascript
let nicknames = {
  joseph: 'Joey',
  margaret: 'Maggie',
};

Object.keys(nicknames);  // [ 'joseph', 'margaret' ]
```

## Arrays and Objects
Arrays and Objects are both data structures to represent compound data. 

### Array
```javascript
[1, 2, 3];
['Monday', 'Tuesday', 'Wednesday'];
['Jan', 31, [2015, 2016]];
```
Use an array if data is like a list and we need to maintain it in a specific order.

### Object
```javascript
{
  firstName: 'Joe',
  lastName: 'Smith',
  gender: 'Male',
  age: 30,
  married: false,
}
```
Use an Object if you need to access values based on the names of those values i.e. "keyed" access.

### Arrays are Objects
In JavaScript, arrays are actual objects!
```javascript
let a = ['hello', 'world'];

console.log(typeof a);        // "object"
console.log(a['1']);          // "world", object's bracket notation to access value
console.log(Object.keys(a));  // ["0", "1"], the keys of the object!

// line 1 is equivalent of:

let a = {
  '0': 'hello',
  '1': 'world',
};

console.log(typeof a);        // "object"
console.log(a['1']);          // "world", object's bracket notation to access value
console.log(Object.keys(a));  // ["0", "1"], the keys of the object!
```
The two are equivalent in terms of logged statements. However, they have slight differences.

### Arrays and the Length Property
JavaScript's built-in Array methods (`join`, `forEach`, `push`, `splice` etc) take the value of the `length` property into consideration while performing their operations. Some methods just uses the value, others set it, and some do both.

Key points about `Array.length`:
- Value is always a non-negative number
- Value of `length` is always 1 greater than the largest **array index** amongst non-negative integer values.
- You can set value of `length` explicitly.

```javascript
let myArray = [];
myArray["foo"] = "bar";
myArray[0] = "baz";
myArray[1] = "qux";

console.log(myArray); // logs ['baz', 'qux', foo: 'bar']
myArray.length; // returns 2 since foo: 'bar' is not an element
myArray.indexOf("bar"); // returns -1 since 'bar' isn't in an element

myArray[-1] = "hello";
myArray[-2] = "world";
myArray.length; // returns 2
myArray.indexOf("hello"); // returns -1 since 'hello' is not in an element
// the fact that myArray[-1] is 'hello' is
// coincidental
myArray.indexOf("world"); // returns -1 since 'world' is not in an element

console.log(myArray); // logs ['baz', 'qux', foo: 'bar', '-1': 'hello', '-2': 'world']
Object.keys(myArray).length; // returns 5 (there are 5 keys at this point)
myArray.length; // returns 2 (but only 2 keys are indexes)
```
- Only values assigned to array indexes (i.e. properties that are non negative integers) are **elements** of that array. Non index properties (e.g. negative integers, non-integers) and their associated values are not elements of the array.
- `Array.prototype.indexOf` returns `-1` if the value passed is not an element of the array, even if the value is associated with a non-index property.
- The value of `length` is dependent on the largest array index.
- Logging an array logs only the value for elements and `key: value` pair for non-elements.
- Use `Object.keys(array).length` and not `array.length` if you want to count all properties in an Array object. 

Implications of explicitly setting an array's `length` property:
```javascript
let myArray = [1, 2, 3];
myArray.length; // returns 3

// setting to a larger value than the current largest array index
myArray.length = 5;
console.log(myArray); // logs (5) [1, 2, 3, empty × 2] on Chrome Console
// logs [1, 2, 3, <2 empty slots>] on Firefox console
// logs [1, 2, 3, <2 empty slots>] on node REPL
myArray.length; // returns 5

myArray[6] = "foo";
myArray.length; // returns 7
console.log(myArray); // logs (7) [1, 2, 3, empty × 3, "foo"] on Chrome Console
// logs [1, 2, 3, <3 empty slots>, "foo"] on Firefox console
// logs [1, 2, 3, , , , 'foo'] on node REPL

// setting to a smaller value than the current largest array index with value
myArray.length = 2;
console.log(myArray); // logs [1, 2]

myArray.length = 5;
console.log(myArray); // logs (5) [1, 2, empty × 3] on Chrome Console
// logs [1, 2, <3 empty slots>] on Firefox console
// logs [1, 2, , ,] on node REPL
myArray.length; // returns 5
```
- Array loses data when `length` property is  set to a value equal to or smaller than the current largest index.
- Empty slots are not elements and are not processed by Array methods. They are displayed to indicate there are gaps between actual elements.
- When we use that valid array index that is not contiguous to the largest array index, it just introduces empty slots. `length` is then this array index + 1.
- `Length` do not only count elements, empty slots are also included in the count.

### Using Object Operations with Arrays
Although you can use object operations like `in` or `delete` on arrays (since they are objects too), this is not recommended as it may cause confusion and yield surprising results. Instead use idiomatic ways to accomplish the same tasks.

`in` operator is used to see if an Object **contains a specific key**. Below code works, but is confusing.
```javascript
0 in [];      // false
0 in [1];     // true
```

To make intent clear, to see if an array has a certain index, we can just compare directly to its `length`:
```javascript
let numbers = [4, 8, 1, 3];
2 < numbers.length;          // true
```

To remove a value from an Array, use `Array.prototype.splice` instead of `delete`.

Like arrays, arithmetic and comparison operators are not useful with objects and often leads to surprising results. When only one operand is an object, JavaScript typically coerce the object to the string `[object Object]`:
```javascript
[] + {};                  // "[object Object]" -- becomes "" + "[object Object]"
[] - {};                  // NaN -- becomes "" - "[object Object]", then 0 - NaN
'[object Object]' == {};  // true
'' == {};                 // false
false == {};              // false
0 == {};                  // false
```

If an object literal is used in certain context e.g. beginning of a line, JavaScript interpret it as a block of code rather than an object.
```javascript
{} + [];                  // 0 -- becomes +[]
{}[0];                    // [0] -- the object is ignored, so the array [0] is returned
{ foo: 'bar' }['foo'];    // ["foo"]
{} == '[object Object]';  // SyntaxError: Unexpected token ==
```

Like array, two objects are considered equal by `==` and `===` operators only if they are the same object:
```javascript
let a = {};
let b = a;
a == a;                   // true
a == b;                   // true
a === b;                  // true
a == {};                  // false
a === {};                 // false
```

**Note**: Use caution when modifying properties of an array directly e.g. changing the `length` property or `delete`ing a property or adding properties with keys that are not array indexes as they can lead to unexpected results when working with arrays. Properties that are not array indexes will not be processed by built-in Array methods. Similarly, "empty slots" are ignored too.

[Back to Top](#section-links)


## Arrays: What is an Element?
```js
let arr = [2, 4, 6]
arr[-3] = 5;
arr['foo'] = 'a';
console.log(arr);              // [ 2, 4, 6, '-3': 5, foo: 'a' ]
console.log(arr.length);       // 3
console.log(Object.keys(arr)); // [ '0', '1', '2', '-3', 'foo' ]
arr.map(x => x + 1);           // [ 3, 5, 7 ]
```
- Arrays are objects. **All indexes** (i.e. positive integer keys) of an array **are properties** of the object (after they are translated to strings) but **not all properties** are **elements** of the array.
- Properties that are **not elements** of the array **do not have positive integer keys**. `a` and `5` in the above example are not elements.
- `Object.keys(arrayVariable)` returns all the keys of the array, including those of non-elements.
- The `length` property of an array returns the value of highest positive index + 1.
- All built-in Array methods will **only act on elements** (Only `2`, `4`, `5` are acted on by the `map` method).
- To determine if an array is empty, we need to first define if we are counting elements or properties:
	```js
	let arr = [];
	arr[-3] = 5;
	arr['foo'] = 'a';
	
	// Is arr empty?
	console.log(arr.length);       // 0                Yes
	console.log(Object.keys(arr)); // [ '-3', 'foo' ]  No
	```
	The above has no elements since none of the values are associated with positive integer indexes. Based on the `length` property, array is empty. However based on keys, it is not empty. 

### Sparse Arrays
```js
let arr = [2, 4, 6];
arr.length = 5;
arr[4] = undefined;
console.log(arr);              // [2, 4, 6, <1 empty item>, undefined ]
console.log(arr.length);       // 5
console.log(Object.keys(arr)); // ['0', '1', '2', '4']
```
- The number of elements in an array is not necessary the same as its length: there can be gaps in the array.
- "Gaps" can be created by increasing the size of the `length` property without adding any values to the array.
- Trying to access the value  at those index positions will return `undefined`. But this `undefined` is meant to represent the **value is not set**. We can see the difference if we have an element whose value is actually `undefined` using `console.log` and its `keys`.
- This feature introduces another ambiguity when deciding if an array is empty. To include gaps, we can use `length`, else we use `Object.keys` bearing in mind some keys may not be positive integers.
	```js
	let arr = [];
	arr.length = 3;
	
	// Is arr empty?
	console.log(arr.length);       // 3      No
	console.log(Object.keys(arr)); // []     Yes
	```

[Back to Top](#section-links)


## Mutability of Values and Objects
Primitive values are immutable. Operations on them simply return a **new value** of the same type. `alpha[0] = 'z'` do nothing except return the string `'z'`.

Objects are mutable. We can change the data they contain without changing their identity.
```js
let alpha = 'abcde';
alpha[0] = 'z';   // "z"  
alpha;            // "abcde"

let arr = ['a', 'b', 'c', 'd', 'e'];
arr[0] = 'z';  // "z"
arr;           // [ "z", "b", "c", "d", "e" ]
```

### Nested Data Structures
A **shallow copy** of a collection involves creating a **new collection**. Its contents are either primitive values or references to object elements of the original collection.

We can create a shallow copy of an array using either the `...` syntax (ES6+) or `Array.prototype.slice()`
```js
let arr = ['a', 'b', 'c'];
let copyOfArr = [...arr];
copyOfArr; // => [ 'a', 'b', 'c' ];
```

```js
let arr = ['a', 'b', 'c'];
let copyOfArr = arr.slice();
copyOfArr; // => [ 'a', 'b', 'c' ];
```

To confirm a new collection is created, any modification to the top layer of the new collection will not affect the original collection.
```js
let arr = ['a', 'b', 'c'];
let copyOfArr = [...arr];

copyOfArr.push('d');

arr; // => [ 'a', 'b', 'c' ]
copyOfArr; // => [ 'a', 'b', 'c', 'd' ]
```

To confirm that only the top layer of the collection is copied, changes to nested i.e. inner layers of the copy will also affect the original collection.
```js
let arr = [['a'], ['b'], ['c']];
let copyOfArr = arr.slice();

copyOfArr[1].push('d');

arr; // => [ [ 'a' ], [ 'b', 'd' ], [ 'c' ] ]
copyOfArr; // => [ [ 'a' ], [ 'b', 'd' ], [ 'c' ] ]
```

```js
let arr = [{ a: 'foo' }, { b: 'bar' }, { c: 'baz' }];
let copyOfArr = [...arr];

copyOfArr[1].d = 'qux';

arr; // => [ { a: 'foo' }, { b: 'bar', d: 'qux' }, { c: 'baz' } ]
copyOfArr; // => [ { a: 'foo' }, { b: 'bar', d: 'qux' }, { c: 'baz' } ]
```

Since `Object.assign` can copy properties of one or more objects into another, it can be use to create shallow copies of objects:
```js
let obj = { a: 'foo', b: 'bar' };
let copyOfObj = Object.assign({}, obj);

copyOfObj; // => { a: 'foo', b: 'bar' }
```

JavaScript allows us to create **deep copies** of nested arrays and plain objects using the methods `JSON.stringify` and `JSON.parse`. 

`JSON.stringify` serializes any objects that only have primitives, arrays or plain objects i.e. convert them to strings. 
`JSON.parse` than convert the string back to an object. Noted that this deep copying technique does not work for custom objects like dates etc.
```js
let arr = [{ b: 'foo' }, ['bar']];
let serializedArr = JSON.stringify(arr);
let deepCopiedArr = JSON.parse(serializedArr);
```
```js
deepCopiedArr[1].push('baz');
deepCopiedArr; // => [ { b: 'foo' }, [ 'bar', 'baz' ] ]
arr; // => [ { b: 'foo' }, [ 'bar' ] ]
```

[Back to Top](#section-links)


## Pure Functions and Side Effects
### Side Effects
A function call that results in any of the following is said to have side effects:
- Modifies an **external variable**. This can involve reassignment of primitive values or mutation to objects.
	```js
	// Side Effects Through Reassignment
	let number = 42;
	function incrementNumber() {
	  number += 1; // side effect: number is defined in outer scope
	}
	```

	```js
	// Side Effects Through Mutation 1
	let letters = ['a', 'b', 'c'];
	function removeLast() {
	  letters.pop(); // side effect: alters the array referenced by letters
	}
	```

	```js
	// Side Effects Through Mutation 2 Object passed as argument
	let letters = ['a', 'b', 'c'];
	function removeLast(array) {
	  array.pop(); // side effect: alters the array referenced by letters
	}
	
	removeLast(letters);
	```

- **Reads or write to any data entities** (files, input/output from keyboard/to console, accessing database, send/receive data from remote site, device interactions such as mouse, trackpad, random number generator, camera or audio speakers etc) non-local to the program.
	```js
	// This code may not work in a browser; use Node instead.
	let readLine = require("readline-sync");
	
	function getName() {
	  let name = readLine.question("Enter your name: "); // side effect: output and input
	  console.log(`Hello, ${name}!`); // side effect: output to console
	}
	```

	```js
	let rand = Math.random(); // side effect: accessed random number generator
	```

- Raising an exception and doesn't catch and handle it.
	```js
	function divideBy(numerator, denominator) {
	  if (denominator === 0) {
	    throw new Error("Divide by zero!"); // side effect: raises an exception
	  }
	
	  return numerator / denominator;
	}
	```

- Calls another function with side effects (e.g. calls `console.log`, `Math.random()`, `readline.question`). This is only important if the side effect affects external variables

### Mixing Side Effects and Return Values
Functions should ideally either have side-effects or return a useful value, not both.

However, sometimes functions had to do both e.g. read from database and return a value.

### Pure Functions
Pure functions are those that have 
- no side effects and 
- Return value depends solely on its arguments  i.e. deterministic return value. 

**Note:** A function that always return `undefined` for all arguments is **still a pure function** if it has no side-effects.

```js
const square = value => value * value;
```

[Back to Top](#section-links)


## Working with the Math Object
Reference: [Math Object MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math)

Common Math methods / properties:
- `Math.PI` property
- `Math.abs(num)` method to force a value positive
- `Math.sqrt(num)` method to find the square root of a number
- `Math.pow(num, nth_power)` method to compare the value of the nth_power of a number.
- `Math.round(num)` method to round number to nearest integer.
- `Math.ceil(num)` method to round number up to next higher integer.
- `Math.floor(number)` method to round number down to the nearest lower integer.
- `Math.random()` method to return a random floating point number between 0 and 1, not inclusive of 1. One application is use this method to create a number between a min and max value:
	```javascript
	const randomInt = function(min, max) {
	  if (min === max) {
	    return min;
	  } else if (min > max) {
	    let swap = min;
	    min = max;
	    max = swap;
	  }
	
	  let difference = max - min + 1;
	  return Math.floor(Math.random() * difference) + min;
	};
	
	console.log(randomInt(1, 5));
	```

[Back to Top](#section-links)


## Working with Dates
Reference: [MDN Date Object](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Date)

 Common methods:
 - `new Date()` to create a new date object with current date and time.
- `getDay()` to return the day of the week (0-6 for Sunday to Sunday)
- `getDate()` to get current day of the month
- `getMonth()` to get the month in the date (0 - 11 for Jan to Dec)
-  `getFullYear()` to get the year in the date
- `getTime()` to get the current date and time in total milliseconds elapsed since 1 Jan, 1970.
- `setDate()` to a date.
- `toDateString()` to get date value as a string.
- `getHours()` and `getMinutes()` to get the hours and minutes of a date.

[Back to Top](#section-links)


## Working with Function Arguments

### The `Arguments` Object
The `arguments` object is the **traditional** way to access all the arguments passed to a function in an invocation.

`arguments` is **not an array** but provides array like features:
- We can access individual values using bracket `[]` notation
- It has a **length** property.
```javascript
function logArgs(a) {
  console.log(arguments[0]);
  console.log(arguments[1]);
  console.log(arguments.length);
}

logArgs(1, 'a');

// logs:
1
a
2
```

```javascript
function logArgs() {
  console.log(typeof arguments);
  console.log(Array.isArray(arguments));
  arguments.pop();
}

logArgs(1, 2);

// logs:
object       // arguments is an "object"
false        // but it is not an Array
TypeError: Object #<Object> has no method 'pop' // and it doesn't have the usual Array methods
```

We can create an Array from the `arguments` object using `Array.prototype.slice.call(arguments)`
```javascript
function logArgs() {
  let args = Array.prototype.slice.call(arguments);
  console.log(typeof args);
  console.log(Array.isArray(args));
  args.pop();
}

logArgs(1, 2);

// logs:
object
true         // args is a proper Array now
```

### Rest Parameters 
ES6 introduced rest parameters as the **modern** way to access an arbitrary number of arguments.

`...args` in the parameter list tells JavaScript to stick 0 or more arguments into the array specified by `args`. Unlike `arguments`, `args` is a true array and works for any name with any `...` prefix.
```javascript
function logArgs(foo, bar, ...args) {
  console.log(foo);
  console.log(bar);
  console.log(args[0]);
  console.log(args[1]);
  console.log(args.length);
}

logArgs('oof', 'rab', 1, 'a');

// logs:
oof
rab
1
a
2
```

[Back to Top](#section-links)