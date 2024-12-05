## Section Links
[Array Basics](#array-basics)\
[Common Array Methods](#common-array-methods)\
[Arrays and Operators](#arrays-and-operators)\
[Rest Parameter](#rest-parameter)

---

## Array Basics
### What Are Arrays
Arrays are a **basic collection type** in JavaScript. They can hold a list of values indexed by a non-negative value.

### Array Creation
Arrays are most commonly created using the Array literal syntax:
```javascript
[]         // an empty Array

[0, 1, 2]  // an Array holding three values

[42, 'hello', false, [3, 5]]  // Arrays can contain any other object
```

Less commonly used, the `Array` constructor can also be used:
```javascript
let count = new Array(1, 2, 3);

// Usually written as:
let count = [1, 2, 3];
```

### Iterating Through an Array
You can use a `for` loop and the array's `length` property to iterate though each element in an array:  
```javascript
let count = [1, 2, 3, 4];
for (let index = 0; index < count.length; index += 1) {
  console.log(count[index]);
}
```

### Accessing Modifying and Detecting Values
JavaScript Array uses **zero-based indexing**: the first element starts from index 0. We use the bracket notation, which is an **operator** and not a method in JavaScript, to access the value at each index:
```javascript
let fibonacci = [0, 1, 1, 2, 3, 5, 8, 13];

fibonacci[0];     // 0
fibonacci[3];     // 2
fibonacci[100];   // undefined
```

We add values using a similar notation:
```javascript
let count = [1, 2, 3];
count[3] = 4;
count;            // [ 1, 2, 3, 4 ]
count.length;     // 4
```

Values can be added to **any** position and need not be contiguous:
```javascript
// continue from the previous code snippet
count[5] = 5;
count[9] = 9;
count[9];         // returns 9
count.length;     // 10
```
**Note**: The length property return a value 1 higher than the greatest index.

Indexes without a value is designated as empty. When accessed, they return `undefined`.
```javascript
// continue from the previous code snippet
count;            // [ 1, 2, 3, 4, empty x 1, 5, empty x 3, 9 ]
count[4];         // undefined
```

We can change the Array's length by assigning a new value to the `length` property: 
```javascript
let count = [1, 2, 3];

count.length = 10;
count;            // [ 1, 2, 3, empty x 7 ]
count.length = 2;
count;            // [ 1, 2 ]; excess elements are lost
```

### Arrays are Objects
The `typeof` operator can be used to display the type for arrays:
```javascript
typeof [];        // "object"
```

`Array.isArray` can be used to determine if an object is an Array:
```javascript
Array.isArray([]);        // true
Array.isArray('array');   // false
```

[Back to Top](#section-links)


## Common Array Methods
JavaScript has an `Array` global object that has a **prototype object**. It is this prototype object that defines all the methods for Arrays and all JavaScript arrays inherits from this prototype object.

`Array.prototype.push()` **appends** specified elements to the end of an array and returns the **new length**. `push` **mutates** the array.
```js
const animals = ['pigs', 'goats', 'sheep'];

const count = animals.push('cows');
console.log(count);
// Expected output: 4
console.log(animals);
// Expected output: Array ["pigs", "goats", "sheep", "cows"]
```

`Array.prototype.pop()` removes and returns the **last element** from an array. `pop()` **mutates** the array.
```js
const plants = ['broccoli', 'cauliflower', 'cabbage', 'kale', 'tomato'];

console.log(plants.pop());
// Expected output: "tomato"

console.log(plants);
// Expected output: Array ["broccoli", "cauliflower", "cabbage", "kale"]
```

`Array.prototype.shift()` removes and returns the **first element** from an array. `shift()` **mutates** the array.
```js
const array1 = [1, 2, 3];

const firstElement = array1.shift();

console.log(array1);
// Expected output: Array [2, 3]
```

`Array.prototype.unshift()` **insert** element(s) at the **beginning** of the array and returns the **new length** of the array. `unshift()` **mutates** the array.
```js
const array1 = [1, 2, 3];

console.log(array1.unshift(4, 5));
// Expected output: 5

console.log(array1);
// Expected output: Array [4, 5, 1, 2, 3]
```

`Array.prototype.indexOf()` returns the **first index** at which a given **element can be found** in the array, or `-1` if it is not present.
```js
const beasts = ['ant', 'bison', 'camel', 'duck', 'bison'];

console.log(beasts.indexOf('bison'));
// Expected output: 1

// Start from index 2
console.log(beasts.indexOf('bison', 2));
// Expected output: 4

console.log(beasts.indexOf('giraffe'));
// Expected output: -1
```

`Array.prototype.lastIndexOf()` returns the **last index** at which a given element can be found, or `-1` if it is not present.
```js
const animals = ['Dodo', 'Tiger', 'Penguin', 'Dodo'];

console.log(animals.lastIndexOf('Dodo'));
// Expected output: 3

console.log(animals.lastIndexOf('Tiger'));
// Expected output: 1
```

`Array.prototype.slice()` returns a **shallow copy** of a portion of an array into a **new array** selected from `start` to `end` (`end` excluded) where `start` and `end` represent the index of items in that array. Original array is not modified.
```js
const animals = ['ant', 'bison', 'camel', 'duck', 'elephant'];

console.log(animals.slice(2));
// Expected output: Array ["camel", "duck", "elephant"]

console.log(animals.slice(2, 4));
// Expected output: Array ["camel", "duck"]

console.log(animals.slice(1, 5));
// Expected output: Array ["bison", "camel", "duck", "elephant"]

console.log(animals.slice(-2));  // copy from second last item to end inclusive
// Expected output: Array ["duck", "elephant"]

console.log(animals.slice(2, -1)); //copy from index 2 up to and exclude last item
// Expected output: Array ["camel", "duck"]

console.log(animals.slice());  // copy all items
// Expected output: Array ["ant", "bison", "camel", "duck", "elephant"]
```

`Array.prototype.splice()` **changes the contents** of an array by removing or replacing existing elements and/or adding new elements **in place**.
```js
const months = ['Jan', 'March', 'April', 'June'];
months.splice(1, 0, 'Feb'); // remove 0 item at index 1, then insert 'Feb'
// Inserts at index 1
console.log(months);
// Expected output: Array ["Jan", "Feb", "March", "April", "June"]

months.splice(4, 1, 'May');  // remove 1 item at index 4, then insert 'May'
// Replaces 1 element at index 4
console.log(months);
// Expected output: Array ["Jan", "Feb", "March", "April", "May"]
```

`Array.prototype.concat()` is used to **merge** two or more arrays. `concat()` does not modify the original array but returns result in a **new array**.
```js
const array1 = ['a', 'b', 'c'];
const array2 = ['d', 'e', 'f'];
const array3 = array1.concat(array2);

console.log(array3);
// Expected output: Array ["a", "b", "c", "d", "e", "f"]
```

`Array.prototype.join()` **creates and returns a new string** by concatenating all the elements in the array, separated by commas or a specified separator string. If the array only has one element, it will be returned without using the separator.
```js
const elements = ['Fire', 'Air', 'Water'];

console.log(elements.join());
// Expected output: "Fire,Air,Water"

console.log(elements.join(''));
// Expected output: "FireAirWater"

console.log(elements.join('-'));
// Expected output: "Fire-Air-Water"
```

[Back to Top](#section-links)


## Arrays and Operators
Operators e.g. `+`, `-`, `*`, `/`, `%`, `+=`, `-=`, `==`, `!=`, `===`, `!==`,
`>`, `>=`, `<`, `<=` are **mostly useless with Array objects** as they give unexpected results. The absence of any error meant it is easy to cause hidden bugs.
### Arithmetic Operators
The `+` operator implicitly coerce the Array object into a String before trying to perform the operation:
```js
let initials = ['A', 'H', 'E'];
initials + 'B';                   // "A,H,EB"
initials;                         // [ "A", "H", "E" ]
```

It **cannot** be used to concat two arrays together:
```javascript
initials + ['B'];      // "A,H,EB"
initials;              // [ "A", "H", "E" ]
```

Other arithmetic operations yields similarly non useful results:
```javascript
[1] * 2;              // 2 -- becomes '1' * 2, then 1 * 2
[1, 2] * 2;           // NaN -- becomes '1,2' * 2, then NaN * 2
```

```javascript
[5] - 2;              // 3
[5] - [2];            // 3
5 - [2];              // 3
5 - [2, 3];           // NaN -- becomes 5 - '2,3', then 5 - NaN
[] + [];              // '' -- becomes '' + ''
[] - [];              // 0 -- becomes '' - '', then 0 - 0
+[];                  // 0
-[];                  // -0
```

### Comparison Operators
Equality operators are not used to compare values in arrays. Instead, they will only **check if two arrays are the same object**. Comparing two different arrays holding the same values will thus return `false`.
```javascript
let friends = ['Bob', 'Josie', 'Sam'];
let enemies = ['Bob', 'Josie', 'Sam'];
friends == enemies;                    // false
friends === enemies;                   // false
[] == [];                              // false
[] === [];                             // false
```

Equality operators on the same object will return `true`
```javascript
let friends = ['Bob', 'Josie', 'Sam'];
let roommates = friends;
friends == roommates;                  // true
friends === roommates;                 // true
```

When an array is compared with a non-array, JavaScript implicitly coerce the array into a String before performing the comparison:
```javascript
[] == '0';               // false -- becomes '' == '0'
[] == 0;                 // true -- becomes '' == 0, then 0 == 0
[] == false;             // true -- becomes '' == false, then 0 == 0
[] == ![];               // true -- same as above
[null] == '';            // true -- becomes '' == ''
[undefined] == false;    // true -- becomes '' == false, then 0 == 0
[false] == false;        // false -- becomes 'false' == 0, then NaN == 0
```

**Note:** Relational comparison operators `>`, `>=`, `<`, `<=` are useless with arrays and objects as they return `true` or `false` in unexpected ways. Do not use them.

[Back to Top](#section-links)


## Rest Parameter
The [**rest parameter**](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/rest_parameters) syntax allows a function to accept an indefinite number of arguments as an array, providing a way to represent [variadic functions](https://en.wikipedia.org/wiki/Variadic_function) in JavaScript.
```js
function sum(...theArgs) {
  let total = 0;
  for (const arg of theArgs) {
    total += arg;
  }  
  // or we can use 
  // for (let idx = 0; idx < theArgs.length; idx++)
  return total;
}

console.log(sum(1, 2, 3));
// Expected output: 6

console.log(sum(1, 2, 3, 4));
// Expected output: 10
```

[Back to Top](#section-links)