## Section Links
[Data Types](#data-types)\
[Variables](#variables)\
[Operators](#operators)\
[Expressions and Statements](#expressions-and-statements)\
[Input and Output](#input-and-output)\
[Explicit Primitive Type Coercions](#explicit-primitive-type-coercions)\
[Implicit Primitive Type Coercions](#implicit-primitive-type-coercions)\
[Conditionals](#conditionals)\
[Looping and Iteration](#looping-and-iteration)\
[Other Notes](#other-notes)

---
## Data Types
In [JavaScript](https://developer.mozilla.org/en-US/docs/Glossary/JavaScript), there are 7 **primitive** data types (aka primitive or primitive value) and 1 compound data type.

### Primitive Data Type
A primitive is simply a value. It is not an [object](https://developer.mozilla.org/en-US/docs/Glossary/Object) and has no [methods](https://developer.mozilla.org/en-US/docs/Glossary/Method) or [properties](https://developer.mozilla.org/en-US/docs/Glossary/Property/JavaScript). The 7 primitive data types are:
1. String
2. Number
3. Undefined
4. Null
5. Boolean
6. Symbol (ES6 and beyond)
7. BigInt (ES9 and beyond)

Data type values can be represented by **literals** (i.e. a notation to represent fixed value in source code).
```js
'Hello'
5.67
7
undefined
null
true
```

All JavaScript **primitives are immutable**. They cannot be changed once created.
```javascript
a = 'hello';
a.toUpperCase();  // the "hello" string is not mutated, but a new "HELLO" string is returned
a;                // still "hello"
```

Primitive values, especially strings, may appear to change during the lifetime of a JavaScript program. This is an illusion as the changes happen because JavaScript assign wholly **new values** to variables that used to contain different values.

#### Why Primitive Values Can Invoke Methods
A primitive e.g. a string primitive `'hello'`, is just a value and not a String object. Hence, they should not have access to any methods or properties. However, they behaves as if they do and can call on methods available to objects of that data type. 

This phenomenon occurs because each primitive has an associated object that can wrap it, and the methods are actually invoked on that object. [The MDN doc](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String#String_primitives_and_String_objects) says this about how string primitives interact with their object types:

> JavaScript automatically converts string primitives to String objects, so that it's possible to use String object methods for primitive strings. In contexts where a method is to be invoked on a primitive string or a property lookup occurs, JavaScript will automatically wrap the string primitive and call the method or perform the property lookup.

This:

```javascript
console.log('Bob'.toUpperCase()); // BOB
```

is equivalent to this:

```javascript
console.log(new String('Bob').toUpperCase()); // BOB
```

With the call to `toUpperCase()`, the primitive string `'Bob'` is passed to the `String` object wrapper, which then passes it internally to `toUpperCase()`.

This works the same way with a string variable as it does for a string literal:

```javascript
let name = 'Bob';
console.log(new String(name).toUpperCase()); // BOB
```

It's important to be aware that the primitive string is not equivalent to the `String` object, as this node experiment will show:

```node
> let name = 'Bob'
'Bob'
> let nameObj = new String('Bob')
[String: 'Bob']
name.toUpperCase()
'BOB'
nameObj.toUpperCase()
'BOB'
> name instanceof String
false
> nameObj instanceof String
true
> name === nameObj.valueOf()
true
```

So, as we have demonstrated here, a string primitive is not an instance of the `String` object. A `String` object has a `valueOf` property which is equivalent to a string primitive.

And again, then, when a string primitive is (syntactically) the receiver of a `String` method, the primitive gets **temporarily wrapped** in a `String` object, and the method is called. So `String` method calls are equivalent either on a `String` object or a string primitive. But in the latter case, when the method call finishes, the `String` object is dereferenced and garbage collected.

The temporal nature of the wrapping of a primitive to object form for method calls is why "mutating" primitives does not work (because `str.foo = 1` is not assigning to the property `foo` of `str` itself, but to an temporal wrapper object)
```node
let str = 'hello'
undefined

> str.foo = 1
1

> str.foo
undefined

> let strObj = new String('hello')
undefined

> strObj
[String: 'hello']

> strObj.foo = 1
1

> strObj.foo
1
```

### Compound Data Type
**Objects** are the **only** compound data type in JavaScript. Arrays, functions and everything that is not a primitive are objects in JavaScript. Objects are **mutable**.

#### Array
An array is a type of object in JavaScript. It is an ordered list and may contain any data type
```JavaScript
[1, 2, 3, 4, 5]
```

It supports **direct access through indexing**. Index numbers start at 0 and unlike some programming language, does not support negative numbers for reverse access
```node
> [1, 2, 3, 4, 5][0]
= 1

> [1, 2, 3, 4, 5][-2]
= undefined
```

It is common practice to include an **optional** trailing comma for the last item.
```node
[
  "Eric Idle",
  "John Cleese",
  "Terry Gilliam",
  "Graham Chapman",
  "Michael Palin",
  "Terry Jones",
]
```

#### Object
A JavaScript object is a collection of key-value pairs
```JavaScript
{ dog: 'barks', cat: 'meows', pig: 'oinks' }
```

We retrieve a value by its key
```node
> ({ dog: 'barks', cat: 'meows', pig: 'oinks' })['cat']
= 'meows'
```

Similar to Arrays, a trailing comma on the last item is optional but a common practice.

### `typeof` Operator
We can use the `typeof` operator to get the data type of any values returned in the form of a string.
```javascript
typeof 1.2;        // "number"
typeof 'hello';    // "string"
typeof false;      // "boolean"
typeof undefined;  // "undefined"
typeof { a: 1 };   // "object"
typeof [1, 2, 3];  // "object" (yes: an array is an object)
typeof null;       // "object" (null both is and isn't an object)
```
From above, we observe the following:
- `undefined` has type `'undefined'` i.e. The `'undefined'` type has only one value: `undefined`
- `null` is of type `'object'`. This is **a bug** present since the origins of JavaScript. It was never fixed to prevent breaking existing code.
- An array `[1, 2, 3]` is an `'object'`

### String
A **String** is a sequence of characters and is used to represent text in a JavaScript program.
```javascript
'Hello, world'
"Hello, world"
'asdac ca,!'
'c'
'45'
''
'©2016 Flambé, Inc.'
```

JavaScript Strings have **no size limit** and can contain any amount of text.

We can use either single or double quote marks for strings. 

Strings can hold any character in the UTF-16 character set.

`\` is the **escape sequence**. It is used with certain prescribed characters for **formatting** purposes:

| Code | Character       |
| ---- | --------------- |
| `\n` | New line        |
| `\t` | Tab             |
| `\r` | Carriage return |
| `\v` | Vertical tab    |
| `\b` | Backspace       |

`\` is also used with standard characters to escape any special meaning and make the trailing character a literal.
```js
> 'He said, \'Hi there!\''  // Escape single quote
= "He said, 'Hi there!'"

let quote = "\"It's hard to fail, but it is worse never to have tried to succeed.\" - Theodore Roosevelt"; // Escaoe double quote
> console.log(quote)
= "It's hard to fail, but it is worse never to have tried to succeed." - Theodore Roosevelt

let a = '\\hello';  // Escape \
> console.log(a)
= \hello
```

#### String Concatenation
Concatenation allows us to append content to an existing string using the `+` operator. 
```javascript
let firstName = 'John';
let lastName = 'Doe';
firstName + ' ' + lastName;  // "John Doe"
```

If both operands are numbers, a mathematical addition is performed instead.

If one operand is a string while the other is a number, JavaScript will **automatically coerce** the number into a string and perform a string concatenation.
```js
> 4 + '4'
= '44'
```

#### String Interpolation
JavaScript use **backticks (\`)** for string interpolation: the expression between `${...}` will be replaced with its evaluated value.
```node
> `5 plus 5 equals ${5 + 5}`
= '5 plus 5 equals 10'
```

#### Character Access
Strings act like a collection of characters. We can use the `String.prototype.charAt(index)` method to retrieve a character from a String.
```javascript
'hello'.charAt(1);  // "e"
```

**Bracket notation** can also be used to perform the same operation:
```javascript
'hello'[1];         // "e"
```

In some programming languages, such as Ruby, bracket notation is a method. In JavaScript, `[]` is actually an **operator**.

Like most programming languages, JavaScript uses **0-based indexing**; the first character has index 0 and the last index is always one less than the string's length. 

| 0   | 1   | 2   | 3   | 4   |
| --- | --- | --- | --- | --- |
| h   | e   | l   | l   | o   |

#### String Length 
Strings have a `length` **property** to tell us the number of characters present in the string:

```javascript
'hello'.length;     // 5
```

#### Working with Long Strings
For long literal strings, it is recommended to write them in chunks, then use concatenation to make our code more readable:
```javascript
let lipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing  ' +
             'eiusmod tempor incididunt ut labore et dolore. Ut ' +
             'enim ad minim veniam, quis nostrud exercitation ' +
             'nisi ut aliquip ex ea commodo consequat. Duis ' +
             'in reprehenderit in voluptate velit esse cillum ' +
             'nulla pariatur. Excepteur sint occaecat cupidatat, ' +
             'sunt in culpa qui officia deserunt mollit anim id.';
```

Alternatively, we append a `\` at the end of each line; this tells JavaScript to ignore the following newline, and concatenate the next line to the current string. **Note**: There should be no trailing spaces after the `\`, else JavaScript will treat them as literal spaces or tabs, and include them in the string. The closing quote mark will also not be found, leading to a syntax error. Leading spaces at the beginning of the line after the will also be interpreted as part of the string's content.

The following example assigns the same string as the previous example to `lipsum`:

```javascript
let lipsum = 'Lorem ipsum dolor sit amet, consectetur adipiscing \
eiusmod tempor incididunt ut labore et dolore. Ut \
enim ad minim veniam, quis nostrud exercitation \
nisi ut aliquip ex ea commodo consequat. Duis \
in reprehenderit in voluptate velit esse cillum \
nulla pariatur. Excepteur sint occaecat cupidatat, \
sunt in culpa qui officia deserunt mollit anim id.';
```

**Negative Example**

This example has two issues:
```javascript
const paragraph = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse sed \
                ligula at risus vulputate faucibus. Aliquam venenatis nibh ut justo dignissim \
                dignissim. Proin dictum purus mollis diam auctor sollicitudin. Ut in bibendum \
                ligula. Suspendisse quam ante, dictum aliquam tristique id, porttitor pulvinar \
                diam. Maecenas blandit aliquet ipsum. Integer vitae sapien sed nulla rutrum \   
                hendrerit ac a urna. Interdum et malesuada fames ac ante ipsum primis in faucibus.';

console.log(paragraph);
```
- There is a `SyntaxError` in assigning the paragraph to the `paragraph` variable. It is not easily visible, but there are spaces at the end of line 5 following the backslash (`\`) character. The purpose of the backslash is to escape the newline character at the end of the line. However, the extra whitespace prevents this from happening, causing a `SyntaxError` `'' string literal contains an unescaped line break` to be raised.
- The program still has a bug, even after removing the extra whitespace on line 5: there are extra spaces in the middle of some of the sentences. This is because the program considers the whole string to be continuous, so the spaces at the beginning of each line (lines 2 to 6) are interpreted as part of the string.

#### Built-in String Methods
JavaScript has a rich set of [built-in methods for strings](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/String).
### Number
JavaScript uses [Double Precision Floats](https://en.wikipedia.org/wiki/Double-precision_floating-point_format) to represent all numbers: integers, decimals and floating point numbers.

The largest safe integer is `9,007,199,254,740,991` (`Number.MAX_SAFE_INTEGER`) and the biggest value is `1.7976931348623157e+308` (`Number.MAX_VALUE`). Any number greater is represented by `Infinity`.

Examples of numbers:
```javascript
1234.60
0.12324324
1
-3.14
```

Numbers support basic arithmetic operations such as addition (`+`), subtraction (`-`), multiplication (`*`) and division (`/`).

Like in other programming languages, floating point cannot precisely represent a value. It is best to use an integer of the smallest relevant unit e.g. cents to represent dollar amount.
```javascript
0.1 + 0.2;    // returns 0.30000000000000004, not 0.3!
```

There are a few special values:
-  `Infinity` and `-Infinity`: represents an infinitely positive and negative number respectively. 
- `NaN`: means "not a number." We will see `NaN` when a math function encounters an error.

We can't use commas or period to group numbers. `123,456,789` and `123.456.789` are **not** valid. Recent versions of JavaScript allows using underscore to group numbers e.g. `123_456_789` but this can not yet be relied upon.

### Booleans
The Boolean data type represents truth-values of logic. They have two literal values: `true` and `false`
```node
> let toggleOn = true
= undefined

> let sessionActive = false
= undefined
```

They are frequently the result of comparison operations:
```node
> 5 === 5
= true

> 100 < 99
= false
```

### Undefined
The value `undefined` is used to represent the **absence of a value**. When a variable is not defined, it has a value of `undefined`.

The `console.log` function is an example of a function that returns `undefined`
```node
> console.log("Hello, World!")
Hello, World!
= undefined
	```

`undefined` also arises when declaring variables without an explicit value
```node
> let foo
= undefined

> foo
= undefined

> let bar = 3
= undefined

> bar
= 3
```

### Null
`null` is similar to `undefined` in that both represents an intentional absence of a value. The main difference between the two is `null` is used explicitly while `undefined` can arise implicitly.
```node
> let foo = null
```

[Back to Top](#section-links)


## Variables
Variables are used to store values. They provide a way to associate data with descriptive names to make the program readable to humans.

### Naming Variables
Choosing a good variable name is one of the most important, yet difficult task in programming as it can affect how readable a code is to another programmer.

Variable Naming Rules:
- JavaScript is **case-sensitive**; `myvariable` is different from `myVariable`
- Variable names can be **any length**
- It must **start with** a letter, an underscore (`_`) or a dollar sign (`$`)
- Subsequent characters must be Unicode letters, numbers, dollar signs or underscores.
- It must not be a [reserved word](https://262.ecma-international.org/5.1/#sec-7.6.1.1).

**Examples of Valid Variable names:**
```javascript
_count
$price
value
my_variable
otherVariable
```

**Examples of invalid variable names:**
```javascript
1count
my#variable
```

### Declaring Variables
Variables should be declared using `let` or `const` keywords before they are used. `var` may be used in older codebases (pre ES6).

**Examples**
```javascript
// single declaration
let myVariable;

// multiple declarations
let myVariable;
let otherVariable;
let anotherVariable;

// Constant declaration
const FOO = 'hello';

// var declaration
var myVariable;
```

### Variable Assignment and Initializers
Once a variable is declared, we use the `=` operator to assign a value to it:
```javascript
let number;

number = 3;  // variable `number` is assigned with value 3
```

We may also combine a variable declaration with its initializer:
```javascript
let myVariable = 'Hello, World';
var otherVariable = 23;
let anotherVariable = true;
const FOO = 42;
```

Note: Initializers and assignment are distinct terminologies. An assignment is a standalone expression that gives a variable a new value; an initializer is `=` combined with the expression to its right in a **variable declaration**.

A variable declared but not assigned a value will have the value `undefined`.
```javascript
let foo;
foo;      // undefined
```

We must initialize a constant at declaration. Once declared, we cannot assign a new value to a constant.
```javascript
const BAR; // Uncaught SyntaxError: Missing initializer in const declaration
```

```javascript
const FOO = 3;
FOO = 4; // Uncaught TypeError: Assignment to constant variable.
```

### Dynamic Typing
JavaScript is a dynamically type language: a variable may be assigned a value of any data type. It can be reassigned to a different type without error. 
```javascript
// initialize to a string
let myVariable = 'Hello, World';

// reassign to a number
myVariable = 23;

// now the variable holds a number value
myVariable;      // 23
```

[Back to Top](#section-links)


## Operators
An operator is a symbol that tells the computer to perform an operation on values (operands).

### Arithmetic Operators
`+` operator is used for addition when both operands are numbers
```node
> 38 + 4
= 42
```

`-` operator is used for subtraction
```node
> 44 - 2
= 42
```

`*` operator is used for multiplication
```node
> 7 * 6
= 42
```

`/` operator is used for division. If both operands are integers, we can still get a decimal or float if result is not a whole number i.e. no result truncation.
```node
> 16 / 4
= 4

> 16 / 2.5
= 6.4
```
```node
> 16 / 5
= 3.2

> 16 / 7
= 2.2857142857142856
```

`%` is a **remainder** operator. It returns the remainder of a division operation. It does not compute the modulo value, nor does it have built-in methods that will compute the modulo value.
```node
> 16 % 4
= 0

> 16 % 5
= 1
```
**Note:** A remainder operation is different from a modulo operation: Results of **remainder operation follows the sign of the first operand** while results of **modulo follows the sign of the second operand**.

| a | b | a % b (remainder) | a modulo b |
|---|---|---|---|
| 17 | 5 | 2 | 2 |
| 17 | -5 | 2 | -3 |
| -17 | 5 | -2 | 3 |
| -17 | -5 | -2 | -2|

### Assignment Operators
The assignment operator (`=`) assigns the value of the right operand to the left operand. For example, `x = 10` assigns `10` to `x`.

JavaScript also have compound assignment operators that combines arithmetic operators with assignment using a shorthand notation:

|Name|Shorthand Operator|Meaning|
|---|---|---|
|Addition Assignment|a += b|a = a + b|
|Subtraction Assignment|a -= b|a = a - b|
|Multiplication Assignment|a *= b|a = a * b|
|Division Assignment|a /= b|a = a / b|
|Remainder Assignment|a %= b|a = a % b|

### Comparison Operators
A comparison operator compares its operands and returns a boolean value. When the operands are of **different type**, JavaScript tries to **implicitly convert** them to suitable types. This implicit conversion can cause problems. Therefore, many JavaScript programmers avoid the use of `==` and `!=` in favor of the strict versions of these operators (`===` and `!==`). The strict comparisons do not perform any conversions.

|Operator|Description|
|---|---|
|Equal (==)|Returns true if the operands are equal|
|Not Equal (!=)|Returns true if the operands are not equal|
|Strict Equal (===)|Returns true if the operands are equal and of the same type|
|Strict Not Equal (!==)|Returns true if the operands are not equal and/or not of the same type|
|Greater than (>)|Returns true if the left operand is greater than the right|
|Less than (<)|Returns true if the left operand is less than the right|

### String Comparisons
We can compare strings just as numbers:
```javascript
// String comparisons use Unicode lexicographical ordering
'a' < 'b';         // true
'Ant' > 'Falcon';  // false
'50' < '6';        // true ('5' precedes '6' lexicographically)
```

### Logical Operators
Logical operators work with both boolean and non-boolean operand.

Logical **And (`&&`)**
```javascript
true && true;    // true
true && false;   // false
false && true;   // false
false && false;  // false
false && [];     // false
```
- Evaluation short circuits when first operand evaluates to false.
- For boolean values, returns `true` if both operands are `true`, and `false` otherwise.
- For non-boolean values this returns the first operand if it can be converted to `false`, and the second operand otherwise.


Logical **Or (`||`)**
```javascript
true || true;    // true
true || false;   // true
false || true;   // true
false || false;  // false
false || [];     // [] (second operand is non-boolean, it is returned as is)
```
- Evaluation short circuits when first operand evaluates to true.
- For boolean values, returns `true` if at least one operand is `true`, and `false` otherwise.
- For non-boolean values this returns the first operand if is truthy, and the second operand otherwise.

Logical **Not (`!`)**
```javascript
!true;   // false
!false;  // true
!!true;  // true
!1;      // false
![];     // false
```
- Returns `true` if its operand is falsy, and `false` otherwise.
- We often use double `!!` to convert an operand to a boolean.
- **Note:** this operator is a unary operator. It takes only one operand. You must specify the `!` before the operand.

[Back to Top](#section-links)


## Expressions and Statements
### Expressions
An expression is **any valid code** that **resolves to a value**.
```javascript
'hello';   // a single string is an expression
10 + 13;   // arithmetic operations are expressions
sum = 10;  // assignments are expressions
```

Common expression types include:
- Arithmetic: these are expressions that evaluate to a number (i.e. `10 + 13`)
- String: these are expressions that evaluate to a character string (i.e. `'Hello' + ', World'`)
- Logical: these are expressions that evaluate to `true` or `false` (i.e `10 > 9`)

An expression can appear anywhere JavaScript expects or allows a value.
```javascript
let a;
let b;
let c;

a = 3;
b = 10 + 3;         // 10 + 3 is an expression that resolves to 13
                    // and used as part of the assignment for sum
c = (a + (3 + b));  // a more complicated expression
```

### Operator Precedence
JavaScript uses rules similar to other languages: 
- multiplication and division operations before addition and subtraction
- Parentheses override default precedence
```javascript
3 + 3 * 4;    // 15
(3 + 3) * 4;  // 24
```

### Increment and Decrement  Operators in Expressions
The increment (`++`) and decrement (`--`) operators increment or decrement their operands by 1. The operator can appear as a prefix or postfix to the operand. When use as a standalone, the form used does not matter:
```javascript
let a = 1;
a++;        // same as "a = a + 1"; a is now 2
++a;        // same as "a = a + 1"; a is now 3
a--;        // same as "a = a - 1"; a is now 2
--a;        // same as "a = a - 1"; a is now 1
```

When used in a more complex expression, the form matters:
```javascript
let a;
let b;
let c;

a = 1;
b = a++;  // equivalent to "b = a; a += 1;". so now b is 1 and a is 2
c = ++a;  // equivalent to "a += 1; c = a;". so now c is 3 and a is 3
```
- The postfix form will evaluate the expression first, then modify the operand.
- The prefix form will modify the operand first, then evaluate the expression.

### Logical Short Circuit Evaluation in Expressions
When an expression contains the logical And (`&&`) or logical Or (`||`) operators, short circuit rules will apply.
- In `a || b`, if `a` is `true`, the result is always `true` and `b` is not evaluated.
- In `a && b`, if `a` is `false`, the result is always `false` and `b` is not evaluated. 
```javascript
let a = true;
let b = false;

a || (b = true);  // b is still false after this, because (b = true) is never evaluated
b && (a = 1);     // a is still true after this, because (a = 1) is never evaluated
```

### Statements
Unlike expressions, statements in JavaScript **does not resolve to useful values** but instead **control program execution**. For example, variable assignments are expressions but variable declaration are statements.
```javascript
let a;                // a statement to declare variables
let b;
let c;
let d = (a = 1);      // this works, because assignments are expressions too
let e = (let f = 1);  // this gives an error, since a statement can't be used
                      // as part of an expression
```

`if` ... `else` ... `switch`, `while` and `for` are also examples of statements as they control program flow.

Since **statements** does not evaluate to values, they **cannot be used as part of an expression**. 
```node
> 5 * let foo
SyntaxError: Unexpected identifier

> console.log(let bar)
SyntaxError: missing ) after argument list
```

Some statements include expressions as part of their syntax. For example, `let` statements can include an initializer to set the value of a variable.
```node
> let foo = 42
= undefined
```
The code to the right of `=` operator is an expression but is part of the `let` statement.

[Back to Top](#section-links)


## Input and Output
### `prompt()` to Get User Input In Browser
The `prompt` method pops up a dialog box with an optional message and ask the user to enter some text. This is used in the browser environment to collect user input.
```javascript
let name = prompt('What is your name?');
let guess = prompt();           // blank prompt window
```
The dialog box will have two buttons. If `Ok` is clicked, `prompt` will return the text as a string. If `Cancel` is clicked, `null` is returned.

### `alert()` to Display Message to User
The `alert` method is used to display a dialog with message and `OK` button to user. This is used when we just need to notify the user but do not need an input from the user.
```javascript
alert('Hello, world');            // alert dialog box with a message
alert();                          // an empty alert dialog box
```

### Logging Debugging Messages to JavaScript Console
The `console.log` method outputs a message to the JavaScript console. This is used for debugging purposes.
```javascript
let name = prompt('What is your name?');

console.log('Hello, ' + name);
```

### Input From Command Prompt
Use the `readline-sync` library to read an input from command prompt. We can use its `question` or `prompt` method to get an input.
```js
let readlineSync = require('readline-sync');

// Wait for user's response.

let userName = readlineSync.question('May I have your name? ');
console.log('Hi ' + userName + '!');

console.log('How old are you? ');
let age = readlineSync.prompt();
```

[Back to Top](#section-links)


## Explicit Primitive Type Coercions
Conversions are operations that convert values of one type to another type. Since primitive types are immutable, the operation merely return a **new value** of the required type.

### Convert Strings to Numbers
**`Number`** function can be used to convert a string containing numeric value to a number:
```javascript
Number('1');             // 1
```

`Number` returns `NaN` if the string cannot be converted to a number:
```javascript
Number('abc123');        // NaN
```

**`parseInt`** and **`parseFloat`** are global functions that handle numeric values in Integer or floating-point format:
```javascript
parseInt('123', 10);     // 123
parseInt('123.12', 10);  // 123, will only return whole numbers
parseInt('123.12');      // 123
parseFloat('123.12');    // 123.12, can handle floating point values
```
Note: `parseInt` takes an optional `radix` argument that represent the base in numeral systems.

### Convert Numbers to Strings
`String` function can be used to convert numbers to strings:
```javascript
String(123);             // "123"
String(1.23);            // "1.23"
```

`toString` method can also be called on a number to convert to string:
```javascript
(123).toString();        // "123"
(123.12).toString();     // "123.12"
```
**Note:** The number literal must be in parenthesis before calling the `toString` method, otherwise it will raise a syntax error complaining "Invalid or unexpected token".

In concatenation, the `+` operator will implicitly convert a number to string if the other operand is a string. 
**Note:** We should not rely on `+` operator for implicit type conversion as the intent is unclear.
```javascript
123 + '';                // "123"
'' + 123.12;             // "123.12"
```

### Convert Booleans to Strings
The `String` function and `toString` method also work on booleans to convert them to strings.
```javascript
String(true);            // "true"
String(false);           // "false"
```

```javascript
true.toString();         // "true"
false.toString();        // "false"
```

### Primitives to Boolean?
There is no direct coercion of strings to booleans. To determine if a string holds a string representation of `true`, we can just compare it with `'true'`:
```javascript
let a = 'true';
let b = 'false';
a === 'true';            // true
b === 'true';            // false
```
### Boolean
The `Boolean` function will convert any value to a boolean based on truthy and falsy rules in JavaScript:
```javascript
Boolean(null);           // false
Boolean(NaN);            // false
Boolean(0);              // false
Boolean('');             // false
Boolean(false);          // false
Boolean(undefined);      // false
Boolean('abc');          // other values will be true
Boolean(123);            // true
Boolean('true');         // including the string 'true'
Boolean('false');        // but also including the string 'false'!
```

The double `!` operator provides a simple way to convert a truthy or falsy value to its boolean equivalent:
```javascript
!!(null);                // false
!!(NaN);                 // false
!!(0);                   // false
!!('');                  // false
!!(false);               // false
!!(undefined);           // false

!!('abc');               // true
!!(123);                 // true
!!('true');              // true
!!('false');             // this is also true! All non-empty strings are truthy in JavaScript
```

[Back to Top](#section-links)


## Implicit Primitive Type Coercions
JavaScript automatically convert values e.g. when working with operands of different types, to facilitate certain operations. The lack of errors may seem convenient but may introduce bugs. Other programming languages tend to raise errors in similar situations to warn programmers.
 ```javascript
1 + true       // true is coerced to the number 1, so the result is 2
'4' + 3        // 3 is coerced to the string '3', so the result is '43'
false == 0     // false is coerced to the number 0, so the result is true
```

### The Plus (+) Operator
The unary plus operator **converts a value into a number**, similar to the `Number` function.
```javascript
+('123')        // 123
+(true)         // 1
+(false)        // 0
+('')           // 0
+(' ')          // 0
+('\n')         // 0
+(null)         // 0
+(undefined)    // NaN
+('a')          // NaN
+('1a')         // NaN
```

The binary plus operator (when used with two operands) will perform string concatenation if one of the operand is a string.
```javascript
'123' + 123     // "123123" -- if a string is present, coerce for string concatenation
123 + '123'     // "123123"
null + 'a'      // "nulla" -- null is coerced to string
'' + true       // "true"
```

When the operands are a combination of numbers, booleans, `null`s or `undefined`, they are converted to numbers and added together:
```javascript
1 + true        // 2
1 + false       // 1
true + false    // 1
null + false    // 0
null + null     // 0
1 + undefined   // NaN
```
- `undefined` is coerced to `NaN`. `1 + NaN` returns `NaN`.

When **one operand is an object** (include arrays and functions), **both** operands are **converted to strings** and concatenated:
```javascript
[1] + 2                     // "12"
[1] + '2'                   // "12"
[1, 2] + 3                  // "1,23"
[] + 5                      // "5"
[] + true                   // "true"
42 + {}                     // "42[object Object]"
(function foo() {}) + 42    // "function foo() {}42"
```

### Other Arithmetic Operators
The remaining arithmetic operators `-`, `*`, `/` and `%` are **only defined** for **numbers** so JavaScript will **automatically convert both operands to numbers**:
```javascript
1 - true                // 0
'123' * 3               // 369 -- the string is coerced to a number
'8' - '1'               // 7
-'42'                   // -42
null - 42               // -42
false / true            // 0
true / false            // Infinity
'5' % 2                 // 1
'hello' * 2             // => NaN * 2 => NaN
```

### Equality Operators
JavaScript has **non-strict equality** operators (`==` and `!=`) and **strict equality** operators (`===`, `!==`). Unlike non-strict equality operators, strict equality operators do not coerce types before comparison and is safer.

#### Strict equality operators
With `===`, two operands are only equal if they are of same type and value:
```javascript
1 === 1               // true
1 === '1'             // false
0 === false           // false
'' === undefined      // false
'' === 0              // false
true === 1            // false
'true' === true       // false
```

#### Non-strict equality operators
With `==`, JavaScript implicitly coerce the operands to the same type using the following rules before comparing:

When the **operands are string and number**, the **string is converted to a number**:
```javascript
'42' == 42            // true
42 == '42'            // true
42 == 'a'             // false -- becomes 42 == NaN
0 == ''               // true -- becomes 0 == 0
0 == '\n'             // true -- becomes 0 == 0
```

When **one operand is a boolean**, it is **converted to a number**:
```javascript
42 == true            // false -- becomes 42 == 1
0 == false            // true -- becomes 0 == 0
'0' == false          // true -- becomes '0' == 0, then 0 == 0 (two conversions)
'' == false           // true -- becomes '' == 0, then 0 == 0
true == '1'           // true
true == 'true'        // false -- becomes 1 == 'true', then 1 == NaN
```

When operands are `null` and `undefined`, `==` always returns `true`.
When operands are both `null` or `undefined`, `==` returns `true`.
When `null` or `undefined` is compared to other values, `==` returns `false`.
```javascript
null == undefined      // true
undefined == null      // true
null == null           // true
undefined == undefined // true
undefined == false     // false
null == false          // false
undefined == ''        // false
undefined === null     // false -- strict comparison
```

Anything compared to `NaN`, even another `NaN`, returns `false`:
```javascript
NaN == 0              // false
NaN == NaN            // false
NaN === NaN           // false -- even with the strict operator
NaN != NaN            // true -- NaN is the only JavaScript value not equal to itself
```

**Note:** `!=` and `!==` operators follows the same rules above, except the results are inverted i.e. `true` becomes `false`.

### Relational Operators
Relational operators (`<`, `>`, `<=` and `>=`) are defined for **numbers** (numeric comparison) and **strings** (lexicographic order) only. 

There are no strict versions of these operators. 

When both operands are strings, their lexicographic order is compared.

Otherwise, JavaScript **implicitly convert** both operands to **number** before comparison.
```javascript
11 > '9'              // true -- '9' is coerced to 9
'11' > 9              // true -- '11' is coerced to 11
123 > 'a'             // false -- 'a' is coerced to NaN; any comparison with NaN is false
123 <= 'a'            // also false
true > null           // true -- becomes 1 > 0
true > false          // true -- also becomes 1 > 0
null <= false         // true -- becomes 0 <= 0
undefined >= 1        // false -- becomes NaN >= 1
```

### Best Practices
- Always use explicit type coercions.
- Always use strict equality operators (`===` and `!==`) for comparison to make code intent clear.
- We should understand implicit type coercion behavior when debugging code.

[Back to Top](#section-links)


## Conditionals
Conditional statements are commands that trigger when a condition is true.

### if...else
```javascript
let score = 80;

if (score > 70) {
  console.log('Congratulations, you passed!');
}
```
- `score > 70` is an expression that evaluates to `true`
- `if (score > 70)` is a conditional statement. When `true`, the accompanying block executes.
- `{ console.log('Congratulations, you passed!'); }` is a block.

The `else` clause accompanying an `if` statement is **optional**. It only run if the statement's conditional evaluates to `false`.
```javascript
if (score > 70) {
  console.log('Congratulations, you passed!');
} else {
  console.log('Sorry, but you need to study more!');
}
```

Another `if` statement may follow an `else` statement, allowing us to test multiple conditions.
```javascript
if (condition1) {
  // statements
} else if (condition2) {
  // statements
} else if (conditionN) {
  // statements
} else {
  // statements
}
```

`if` statements may be nested inside another `if`:
```javascript
if (condition1) {
  if (nestedCondtion) {
    // statements
  } else {
    // statements
  }
} else if (condition2) {
  // statements
}
```

### Truthy and Falsy
There are **6 "falsy"** values in JavaScript, including `false`. 
```javascript
if (false)        // falsy
if (null)         // falsy
if (undefined)    // falsy
if (0)            // falsy
if (NaN)          // falsy
if ('')           // falsy
```

Everything else evaluates to `true`.
```javascript
if (true)         // truthy
if (1)            // truthy
if ('abc')        // truthy
if ([])           // truthy
if ({})           // truthy
```

When using logical operators, the result does not need to be either `true` or `false`:
```javascript
// With the logical operator the return values are such:
1 || 2;           // 1
1 && 2;           // 2

// Using the logical operator as a `condition` in an if statement
if (1 || 2)       // truthy
if (1 && 2)       // truthy
```

### Switch
The `switch` statement compares an expression with multiple `case` labels. When a case matches (**using strict equality comparison**), the statement following it executes:
```javascript
let reaction = 'negative';

switch (reaction) {
  case 'positive':
    console.log('The sentiment of the market is positive');
  case 'negative':
    console.log('The sentiment of the market is negative');
  case 'undecided':
    console.log('The sentiment of the market is undecided');
  default:
    console.log('The market has not reacted enough');
}

// console output
The sentiment of the market is negative
The sentiment of the market is undecided
The market has not reacted enough
```
**Note:** Execution from the matched block continues to subsequent cases until it encounters a `break` statement. We call this "falls through" execution.

This is corrected but inserting `break` in each case statement:
```javascript
let reaction = 'negative';

switch (reaction) {
  case 'positive':
    console.log('The sentiment of the market is positive');
    break;
  case 'negative':
    console.log('The sentiment of the market is negative');
    break;
  case 'undecided':
    console.log('The sentiment of the market is undecided');
    break;
  default:
    console.log('The market has not reacted enough');
}

// console output
The sentiment of the market is negative
```

### Comparing values with NaN
`NaN` is a special value in JavaScript that represent an illegal operation on numbers
```js
console.log(0 / 0);          // NaN
console.log(Number('abc'));  // NaN
console.log(Math.sqrt(-1));  // NaN
console.log(undefined + 1);  // NaN
```

`NaN` stands for "Not a Number". However, it is of type `Number`.
```js
console.log(typeof(NaN));    // 'number'
```

As highlighted above, `NaN` returns `false` when compared to anything, including another `NaN`
```js
console.log(10 === NaN);     // false
console.log(10 < NaN);       // false
console.log(10 > NaN);       // false
console.log(NaN === NaN);    // false
```

To determine if a value is `NaN`, we can use the **`Number.isNaN`** function or **`Object.is`** function.
```js
let foo = NaN;
console.log(Number.isNaN(foo));      // true

console.log(Number.isNaN('hello'));  // return false since `'hello'` is not NaN

console.log(Object.is(foo, NaN));    // true
```

[Back to Top](#section-links)


## Looping and Iteration
Loops allow a statement or a block to execute repeatedly when certain conditions are `true`.

### The `while` loop
```javascript
let counter = 0;
let limit = 10;

while (counter < limit) {
  console.log(counter);
  counter += 2;
}
```

Result:
```terminal
0
2
4
6
8
```

### Infinite Loops
This occurs when the condition never evaluates to `false`. This is frequently a mistake and unintentional.
```javascript
let counter = 0;
let limit = 10;

while (counter < limit) {
  console.log(counter);
}
```

### Break and Continue
A `break` statement **exits a loop** when executed:
```javascript
let counter = 0;
let limit = 10;

while (true) {
  counter += 2;
  if (counter > limit) {
    break;
  }

  console.log(counter);
}
```

```terminal
2
4
6
8
10
```

A `continue` statement **skips the current iteration of a loop** and **returns to the top of the loop**:
```javascript
let counter = 0;
let limit = 10;

while (true) {
  counter += 2;
  if (counter === 4) {
    continue;
  }

  if (counter > limit) {
    break;
  }

  console.log(counter);
}
```

Result:
```terminal
2
6
8
10
```

### The "do...while" Loop
This is similar to a while loop, except the statements in the loop are executed at least once, even when the conditional are "falsy" to begin with.
```javascript
let counter = 0;
let limit = 0;

do {
  console.log(counter);
  counter += 1;
} while (counter < limit);
```

### The "for" Loop
There are three components to the loop: setting initial state, evaluate a condition, updating the state: 
```javascript
for (initialExpression; condition; incrementExpression) {
  // statements
}
```

An iterator variable, commonly named `i` or `j`, is frequently used:
```javascript
for (let i = 0; i < 10; i += 1) {
  console.log(i);
}
```

The execution flow for a `for` statement is as follows:
1. Execute the initialization statement.
2. Evaluate the condition.
3. Execute the body of the loop.
4. Execute the increment expression.
5. Return to step 2 for the next iteration.

All **three components of the `for` statement are optional**:
```javascript
// put initialization outside of the loop

let index = 0;
for (; index < 10; index += 1) {
  console.log(index);
}
```

```javascript
// manually check condition and break out of the loop
// If you omit the condition component in the "for", JavaScript assumes true

for (let index = 0; ; index += 1) {
  if (index >= 10) {
    break;
  }

  console.log(index);
}
```

```javascript
// manually increment the iterator

for (let index = 0; index < 10; ) {
  console.log(index);
  index += 1;
}
```

[Back to Top](#section-links)


## Other Notes
### Printing vs Returning Values
Printing a value to screen is not the same as returning a value. `console.log` method prints the evaluated value to the console and returns `undefined`
```node
> console.log('Howdy')
Howdy
= undefined
```

[Back to Top](#section-links)


