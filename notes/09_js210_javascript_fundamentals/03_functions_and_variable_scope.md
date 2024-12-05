
## Section Links
[Defining Functions](#defining-functions)\
[Function Invocations and Arguments](#function-invocations-and-arguments)\
[Nested Functions](#nested-functions)\
[Functional Scopes and Lexical Scoping](#functional-scopes-and-lexical-scoping)\
[Function Declarations and Function Expressions](#function-declarations-and-function-expressions)\
[Hoisting](#hoisting)\
[Objects vs Primitives](#objects-vs-primitives)\
[Variables as Pointers](#variables-as-pointers)\
[Pass by Reference vs Pass by Value](#pass-by-reference-vs-pass-by-value)\
[Closures](#closures)

---
## Defining Functions
A function declaration has the following structure:
- The `function` keyword
- The name of the function
- A list of comma separated parameters
- A block of statements i.e. the function body

Below, we declare a function named `triple` with a single parameter `number`. The code snippet also invoke the function multiple times:
```javascript
function triple(number) {
  console.log('tripling in process...');
  return number + number + number;
}

// call function with a value argument
console.log(triple(5));                // logs 15

// call function with a variable argument
let someNumber = 5;
console.log(triple(someNumber));       // logs 15

// call function and store result in a variable
let result = triple(5);
console.log(result);                   // logs 15
```

### Function Return Value
The `return` statement specify the value to be returned by the function. If a function has no explicit `return` statement or the `return` statement does not have a value, `undefined` will be implicitly returned.

### Parameters vs Arguments
Developers often confuse between the terms parameters and arguments. The correct usage should be:

| If you are ...          | Then you should use ... |
| ----------------------- | ----------------------- |
| **Defining** a function | _parameters_            |
| **Invoking** a function | _arguments_             |
```javascript
// When we define the function, a and b are called parameters.
function multiply(a, b) {
  // When this code runs, they are called arguments.
  return a * b;
}

multiply(5, 6);  // 5 and 6 are also arguments
```

[Back to Top](#section-links)


## Function Invocations and Arguments
The standard way to invoke a function is to append `()` to its name.
```javascript
function startle() {
  console.log('Yikes!');
}
```

```javascript
startle();

// logs:
Yikes!
```

Function names are simply **local variables** referencing a function type. Hence we can assign the function to a new local variable and call it with the new name:
```javascript
let surprise = startle;
surprise();

// logs:
Yikes!
```

### Argument Mismatch
```javascript
function takeTwo(a, b) {
  console.log(a);
  console.log(b);
  console.log(a + b);
}
```

```javascript
takeTwo(1);

// logs:
1
undefined
NaN
```
- Calling a function with **the wrong number** of arguments **does not** raise an error.
- **Missing arguments** will assume the value of `undefined`.
- `NaN` was the result of the operation `1 + undefined` and not due to the argument mismatch.
- **Extra arguments** are simply ignored.
	```javascript
	takeTwo(1, 2, 4);
	
	// logs:
	1
	2
	3
	```

[Back to Top](#section-links)


## Nested Functions
We can nest functions within other functions. There is no limit to the level of nesting but doing it will increase the complexity of that function.
```javascript
function circumference(radius) {
  function double(number) {      // nested function declaration
    return 2 * number;
  }

  return 3.14 * double(radius);  // call the nested function
}
```

[Back to Top](#section-links)


## Functional Scopes and Lexical Scoping
A variable's scope is the part of the program where that variable is accessible by name.

### The Global Scope
The global scope is the top level scope in a program. A variable is said to have global scope if it is accessible from declaration to the end of the program.
```javascript
let name = 'Julian';
console.log(name);
```
In the small program above, `name` is said to have global scope.

### Function Scope
Function scope is a local scope within the function body. It is created when we define a function.
```javascript
let name = 'Julian';

function greet() {
  let myName = name;
  console.log(myName);
}

greet();   // => Julian
```
- The above code has two scopes: the global scope and the scope formed by the declaration of the `greet` function.
- `name` and `greet` are variables in the global scope while `myName` declared inside a function have a local scope within the `greet` function only.

The code within an inner scope can access any variables in the **same or any surrounding scope**: Within the `greet` function in the code snippet above, we can access the `name` variable but `myName` cannot be accessed outside the function body. 

This works no matter how deeply nested a function is:
```javascript
let name = 'Julian';    // global scope

function greet() {      // `greet` function scope
  function say() {      // `say` function scope
    console.log(name);
  }

  say();                // `greet` function scope
}
```

```javascript
greet();     // logs: Julian
```

### Block Scope
#### What Is a Block?
In JavaScript, a _block_ generally refers to code segments bounded within curly braces `{ ... }`. They tend to **appear by themselves or with statements** such as `if ... else`, `while`, `do ... while`, `for`, `switch` and `try ... catch`. 
```Javascript
{
  // this is a block
  let foo = 42;
  console.log(foo);
}

if (answer === 'yes') {
  // this is a block
  console.log('yes');
} else {
  // this is another block
  console.log('nope');
}

while (answer != 'no') {
  // this is also a block
  doSomething();
}
```

**Not all curly braces define a block**. For example, function bodies and object literals are also bounded by `{}` but are not blocks. 
```js
function foo() {
  // A function body, not a block
  let foo = 42;
  console.log(foo);
}

let foo = {
  // An object and not a block
  bar: 42
};
```

Similar to function definition, a block also creates a local scope known as a **block scope**. The block accompanying the `while` statement below creates a block scope:
```javascript
let name = 'Julian';       // `name` is in global scope

function greet() {         // `greet` is also in global scope
  let counter = 0;         // `counter` is in function scope
  while (counter < 3) {
    let myName = name;     // `myName` is in block scope
    console.log(myName);
    counter += 1;
  }

  // console.log(myName); // would raise an error (myName not in scope)
  console.log(counter);   // => 3
}

greet();                  // => Julian (3 times)
// console.log(myName);   // would raise an error (not in scope)
// console.log(counter);  // would raise an error (not in scope)
```
Similar to function scopes, code inside a block scope can access any variables within the block and any surrounding scopes. 

### Lexical Scoping
Lexical scope uses the structure of the source code to determine the variable's scope. The code does not have to be executed for the scope to exist. For example, when we define a function, it creates its own scope even if that function was never executed and has no variables of its own.

At any code location, a hierarchy of scopes exist: from the local scope up to the program's global scope.

JavaScript looks for a variable by searching from the **bottom of the scope hierarchy to the top**. The search ends once the first matching name is found. This is why a variable by the same name in the lower scope can **block/shadow** a variable by the same name in the higher scope.

### Adding Variables to Current Scope
We can add variables to the current scope in a variety of ways:
- Use the `let` or `const` keywords
- Use the `var` keywords (for legacy code)
- Define parameters for a function. Each parameter is a local variable of that function scope
- A function definition also creates a variable with the same name as the function
- A class declaration also creates a variable with the same name. 
```javascript
function lunch() {    // A function declaration creates a new variable scope
  let food = 'taco';  // 1. Add a new variable food within the current variable scope
}

function eat(food) {  // 2. Parameters create variables during function invocation
  console.log('I am eating ' + food);
}

function drink() {    // 3. Add a new variable drink within the global variable scope
  console.log('I am drinking a glass of water');
}
```

### Variable Assignment
Variable scoping rules apply to both assignment and referencing.
```javascript
country = 'Liechtenstein';
```
The above code checks the current scope and then each higher scope to look for a variable named `country` until it finds a match, then set it with the value `Liechtenstein`.

During assignment, if JavaScript can't find a matching variable, it will create a new **global variable** instead. This is implicit and usually not what we wanted and can be a source of bugs.
```javascript
// no other code above
function assign() {
  let country1 = 'Liechtenstein';
  country2 = 'Spain';
}

assign();
console.log(country2);   // logs: Spain
console.log(country1);   // gets ReferenceError
// no other code below
```
- `country2` cannot be found so JavaScript create a new **global** variable by that name.
- Hence, `country2` can be accessed outside the `assign` function but `country1` cannot.

### Variable Shadowing
```javascript
let name = 'Julian';

function greet() {
  let name = 'Logan';
  console.log(name);
}
```

```javascript
greet();  // logs: Logan
```
There is two `name` variables, one with local scope within `greet` and another with a global scope. Within the `greet` function, the local scoped `name` shadows the outer `name` variable. Hence `greet()` can only print the value in the local scoped `name`.

If a function definition has a parameter with the same name as a variable from an outer scope, the parameter will shadow the outer variable:
```javascript
let name = 'Julian';

function greet(name) {
  console.log(name);
}
```

```javascript
greet('Sam');  // logs: Sam
```

JavaScript throws a `ReferenceError` exception if it cannot find a variable in the scope hierarchy.
```javascript
state;   // raises error: ReferenceError: state is not defined
```

[Back to Top](#section-links)


## Function Declarations and Function Expressions
### Function Declarations
Similar to variables declared using `let` or `const`, a function declaration must **begin** with the `function` statement.
```javascript
function hello() {
  return 'hello world!';
}

console.log(typeof hello);    // function
```

A function declaration not only creates a function, but also a variable (`hello` in this example) by the same name. The value referenced by this variable is the function itself.

This functional variable obeys general scoping rules, and can be used like other JavaScript variables.
```javascript
function outer() {
  function hello() {
	return 'hello world!';
  }

  return hello();
}

console.log(typeof hello);    // can't access a local scope from here

const foo = outer;            // assign the function to a constant
foo();                        // we can then use it to invoke the function
```

### Function Expression
A function expression is a syntax that **defines a function as part of a larger expression**: function expression **does not** begin with `function`.
```javascript
const hello = function () {   // We can also use let instead of const
  return 'hello';
};

console.log(typeof hello);    // function
console.log(hello());         // hello
```
Here, we define an anonymous function i.e. one without a name, and assign it to variable `hello`. We can then use this variable to invoke this function.

A function can also be returned in a function expression:
```javascript
let foo = function () {
  return function () {   // function expression as return value
    return 1;
  };
};

let bar = foo();         // bar is assigned to the returned function

bar();                   // 1
```

### Named Function Expressions
A named function expression creates a function with name as part of a larger expression:
```javascript
let hello = function foo() {
  console.log(typeof foo);   // function
};

hello();

foo();                       // Uncaught ReferenceError: foo is not defined
```

Unlike a function declaration, the function name of a named function expression has a function scope: it can only be used within its own function body. Trying to access it anywhere outside raises a reference error.

Despite this limitation, named function expressions is better than anonymous function when we need to debug a code as the debugger will show the function name in the call stack.

### Function Declaration vs Function Expression
If a statement begin with `function`, it is a function declaration. Otherwise it is a function expression.

Even having a parentheses is enough to turn a function declaration into a function expression:
```javascript
function foo() {
  console.log('function declaration');
}

(function bar() {
  console.log('function expression');
});

foo();    // function declaration
bar();    // Uncaught ReferenceError: bar is not defined
```

**Note:** A function defined using a function declaration must always have a name. It cannot be an anonymous function. This is because the declaration process also create a variable by the same name.

### Arrow Functions
Javascript introduces arrow function in ES6: a shorthanded way to write a function expression.

The following function expression: 
```js
const multiply = function(a, b) {
  return a * b;
};
```

Can be rewritten using arrow function syntax:
```js
const multiply = (a, b) => {
  return a * b;
};
```

Arrow Function Conversion Rules:
1. `function` keyword can be removed.
2.  Insert `=>` between parameter list and opening brace `{`
3. When function body only have 1 line, we can further simplify by removing braces and writing entire function on single line:
	```js
	const multiply = (a, b) => return a * b;
	```
4. `return` keyword can also be removed for single line function:
	```js
	const multiply = (a, b) => a * b;
	```
5. For single parameter, the parentheses can be omitted.
	```js
	const printName = (name) => console.log(name);
	
	const printName = name => console.log(name);
	```

Arrow functions are most often used as **callback functions**. A callback function is a function **passed into another function as an argument**, which is then **invoked by the outer function** to complete some action.

For example, we pass an anonymous callback function to `map` which invoke it on each element of the array:
```js
[1, 2, 3].map(function (element) {
  return 2 * element;
}); // returns [2, 4, 6]
```

can be rewritten into an arrow function:
```js
[1, 2, 3].map((element) => 2 * element); // returns [2, 4, 6]
```

parentheses can be removed as there is only 1 parameter:
```js
[1, 2, 3].map(element => 2 * element); // returns [2, 4, 6]
```

### Style Notes
- Use arrow functions for callback
- Choose either function declaration or function expression. Use it consistently throughout program.
- If function expressions is used, named function expression are better for debugging.

[Back to Top](#section-links)


## Hoisting
### The `var` Statement
Before `let` and `const` were introduced in ES6, the `var` statement was the only way to declare both variables and constants.

```js
var foo;
var bar = "qux";
```
Both `var` statements create a variable. `foo` is set to `undefined` while `bar` is set to `"qux"`.

An equivalent using the current syntax of `let`  is shown below:
```js
let foo;
let bar = "qux";
const baz = 3.1415;
```
- The two `let` statements create `foo` and `bar` with values `undefined` and `"qux"` respectively. 
- The `const` statement now allow us to create a **constant variable** whose value cannot change after declaration. This is **not possible under `var`**.

### Differences between `var` and `let`
1. Variables declared using **`var`** at the top level of a program creates a **property on the global object** (`global` in Node or `window` in a browser) while `let` does not. `let` is thus safer to use since placing properties on the global object may lead to bugs.
	```js
	// Use the Node REPL for this example.
	// Type the commands one at a time - don't use copy and paste.
	
	var bar = 42;
	console.log(global.bar); // 42
	bar += 1;
	console.log(global.bar); // 43
	
	let foo = 86;
	console.log(global.foo); // undefined
	```

	**Note:** If we declare a variable inside a function, the variable is not stored as a property of the global object or any other object.
	```js
	function foo() {
	  var bar = 42;
	  console.log(global.bar); // undefined
	}
	
	foo();
	```

2. `let` is **block-scoped** while `var` is **function-scoped**. A block-scoped variable is only visible within the block it is declared while a function-scoped variable is visible throughout the function it is declared. **Note:** Not everything within `{ ... }` is a block. see [block](#block-scope))
	```js
	function foo() {
	  if (true) {
	    var a = 1;
	    let b = 2;
	  }
	
	  console.log(a); // 1
	  console.log(b); // ReferenceError: b is not defined
	}
	
	foo();
	```
	`a` declared with `var` can be accessed outside the block which may lead to unexpected behavior. Block scope of `let` is thus safer.

	```js
	function foo() {
	  if (false) {
	    var a = 1;
	  }
	
	  console.log(a); // undefined
	}
	
	foo();
	```
	The scope of variables declared with `var` is function-level, not block level. Therefore after [hoisting](#hoisting), this code becomes:
	```javascript
	function foo() {
	  var a;
	  if (false) {
		a = 1;
	  }
	
	  console.log(a);
	}
	
	foo();
	```
	Since we declare but never assign `a`, `undefined` is logged. If `a` were never declared, it would have resulted in a `ReferenceError` instead.

### Declared Scope vs Visibility Scope
**How** a variable is declared will affect its scope, aka declared scope. Declared scope can be function-scope or block-scope.

| Declared Scope | How Variable Declared |
| --- | --- |
| Function Scope | `function`, `var` |
| Block Scope | `let`, `const`, `class` |
```js
let foo = 1;        // declared scope is block scope
var bar = 2;        // declared scope is function scope

if (true) {
  let foo = 3;      // declared scope is block scope
  var qux = 4;      // declared scope is function scope
}

function bar() {    // declared scope is function scope
  let foo = 5;      // declared scope is block scope
  var bar = 6;      // declared scope is function scope

  if (true) {
    let foo = 7;    // declared scope is block scope
    var qux = 8;    // declared scope is function scope
  }
}
```

**Where** a variable is declared will affect where it is visible, aka visibility scope. Visibility scope can be global, local (block) or local(function).
```js
let foo = 1;        // visibility scope is global
var bar = 2;        // visibility scope is global

if (true) {
  let foo = 3;      // visibility scope is local (block)
  var qux = 4;      // visibility scope is global
}

function bar() {    // visibility scope is global
  let foo = 5;      // visibility scope is local (function)
  var bar = 6;      // visibility scope is local (function)

  if (true) {
    let foo = 7;    // visibility scope is local (block)
    var qux = 8;    // visibility scope is local (function)
  }
}
```

### What is Hoisting?
The process where **variable declarations** _appears_ to be **lifted to the top of their respective function or block**, depending whether they are function or block scoped, is called **hoisting**. 

This is the reason why we seemed to be able to reference a variable or call a function before they are declared without error:
```js
console.log(getName());  //logs 'Pete'

function getName() {
  return "Pete";
}
```

The above code behaves **as if** the code is written as the following even though the code has not changed.
```js
function getName() {
  return "Pete";
}

console.log(getName());
```

### Hoisting for Variables Declared Using `var`, `let` and `const`
Variables declared using `var`, `let` and `const` are all hoisted. However there are differences in behavior:
- A **`var` variable** is hoisted with an initial value of **`undefined`**, same as the value at normal declaration without initialization.
	```js
	console.log(bar); // undefined
	var bar = 3;
	console.log(bar); // 3
	```
- A **`let` or `const`** variable is hoisted without any initial value. These **unset** variables are said to be in the **Temporal Dead Zone (TDZ)**.
	```js
	console.log(foo); // ReferenceError: Cannot access 'foo' before initialization
	let foo;
	```

	```js
	console.log(qux); // ReferenceError: Cannot access 'qux' before initialization
	const qux = 42;
	```

	**Note:** the error for TDZ variables is different from if the variables are never declared at all:
	```js
	console.log(baz); // ReferenceError: baz is not defined
	```

- We **cannot declare** a `let` or `const` variable and a function with the **same name**. This is allowed if `var` is used with no error raised. Hence, using `let` or `const` is preferred as it prevent bugs caused by name clashes:
	```js
	let foo = 3;
	function foo() {}; // SyntaxError: Identifier 'foo' has already been declared
	```

	```js
	function foo() {};
	let foo = 3;  // SyntaxError: Identifier 'foo' has already been declared
	```

	```js
	var foo = 3;
	function foo() {};
	```
	is equivalent to:
	```js
	function foo() {};
	foo = 3;
	```

### Hoisting for Function Declarations
**Function declarations** are hoisted to the **top of its scope**:
```javascript
console.log(hello());

function hello() {
  return 'hello world';
}
```

is equivalent to:
```javascript
function hello() {
  return 'hello world';
}

console.log(hello());      // logs "hello world"
```


Hoisting also occurs with nested functions:
```js
function foo() {
  return bar();

  function bar() {
    return 42;
  }
}
```
Even though `bar` was declared at the end of `foo`, we can still call it at the beginning because hoisting makes `bar` available throughout `foo`.

**Note:** **Functions within a block** produces inconsistent/unpredictable hoisting behaviors:
```js
function foo() {
  if (true) {
    function bar() {
      console.log("bar");
    }
  } else {
    function qux() {
      console.log("qux");
    }
  }

  console.log(bar);
  bar();

  console.log(qux);
  qux();
}

foo();
```

Could lead to any of the below results:
```plaintext
[Function: bar]
bar
undefined
TypeError: qux is not a function
```

```plaintext
[Function: bar]
bar
[Function: qux]
qux
```

```plaintext
undefined
TypeError: bar is not a function
```

```plaintext
ReferenceError: bar is not defined
```

Hence, we should **avoid** nesting function declarations inside non-function blocks. If we can't avoid it, use a function expression instead.

### Hosting for Function Expressions
Function expression usually involves assigning a function to a declared variable. Hence, the **declared variable** being assigned to the function **will be hoisted**:

```javascript
console.log(hello());

var hello = function () {
  return 'hello world';
};
```

is equivalent to:
```javascript
var hello;

console.log(hello());    // raises "TypeError: hello is not a function"

hello = function () {
  return 'hello world';
};
```

### Hoisting Order between Variable and Function Declarations
When both variable and function declaration exists, we can assume the **function declaration is hoisted above the variable declaration**.

```javascript
bar();              // logs undefined
var foo = 'hello';

function bar() {
  console.log(foo);
}
```

is equivalent to:
```javascript
function bar() {
  console.log(foo);
}

var foo;

bar();          // logs undefined
foo = 'hello';
```
It is easy to assume that `foo` will be referencing the value `hello` since `foo` was declared and initialized before `bar` declaration. Hoisting of the function `bar` above the variable `foo` declaration meant that `foo` was still `undefined` when called.

The order matters, especially when both `var` variable and function shared the same name:
```javascript
bar();             // logs "world"
var bar = 'hello';

function bar() {
  console.log('world');
}
```

is equivalent to:
```javascript
function bar() {
  console.log('world');
}

bar();              // logs "world"
bar = 'hello'
```
Since function is hoisted first, the declaration of variable by the same name becomes redundant. What remains becomes a reassignment of the `bar` variable to a string `hello`.

A slight change in code order gives rise to totally different behavior due to hoisting:
```javascript
var bar = 'hello';
bar();             // raises "TypeError: bar is not a function"

function bar() {
  console.log('world');
}
```

has the following hoisted behavior:
```javascript
function bar() {
  console.log('world');
}

bar = 'hello';
bar();             // raises "TypeError: bar is not a function"
```

### Best Practices To Avoid Confusion
1. Use `let` and `const` for variable declaration instead of `var`. That can avoid subtle bugs due to e.g. name collision.

2. If `var` had to be used e.g. for legacy code, declare all variable at the top of scope.
	```javascript
	function foo() {
	  var a = 1;
	  var b = 'hello';
	  var c;
	
	  …
	}
	```

3. When `let` and `const` is used, declare them as close to first usage as possible.
	```javascript
	function foo(bar) {
	  console.log("Hello world!");
	
	  let result;
	  if (bar) {
	    let squaredBar = bar * bar;
	    result = squaredBar + bar;
	  } else {
	    result = "bar hasn't been set";
	  }
	
	  return result;
	}
	
	console.log(foo(3));           // 12
	console.log(foo(undefined));   // bar hasn't been set
	```

4. Declare functions before calling them:
	```javascript
	function foo() {
	  return 'hello';
	}
	
	foo();
	```

In essence, declare variable in such a way to without the need to apply hoisting effect to facilitate understanding.

### Hoisting Isn't Real
Hoisting is actually just a **mental model** to help us explain the observed result. It is not real in the sense that no code shifting actual occur. 

This mental model is not perfect as there remain edge cases that are not explained by hoisting (see [Edge Case](#sample-edge-case-for-hoisting-model)).

The hoisting behavior happens because of JavaScript two phases:
- The **creation phase** where JavaScript comb through the entire code from **top to bottom** in sequence to **discover declaration statements** of all variables, functions and class to build a library of all identifiers in the program. Based on where and how those declaration occurs, these identifiers are added to either the global or local (function or block) scope. When creation completes, all identifiers and their scope are known.
- At execution, JavaScript can just retrieve the correct identifier based on the current scope.
- In below example, function `boo`, which has a global scope, is identified during creation phase.  During execution, `boo()`, which has global scope, will cause JavaScript to look for variable `boo` in the global scope for invocation. As this name was already found during execution, JavaScript will call this function.
	```js
	boo();
	
	function boo() {
	  console.log("Boo!");
	}
	```

#### Sample Edge Case for Hoisting Mental Model
```js
let foo = "hello";

function foo() {        // syntax error: foo already exist
  console.log("hello");
}
```
Based on hoisting, we will assume the function declaration was hoisted above the `let` statement. Hence the `syntax error` complaining the identifier `foo` already exist is caused by line 1 due to redeclaration of an existing variable  `foo`. 

However, what actually cause the error is line 3. Since creation phase runs sequentially, line 1 pick up `foo` in the global scope. When it encounter a declaration of existing variable `foo` in line 3, that is when the Syntax error is triggered. 

**Note:** Syntax error occurs during the **creation phase** of JavaScript.

If we were to reverse the declarations, the cause of Syntax error is now due to `let foo = "hello` instead. This behavior cannot be explain by the hoisting model but is consistent with creation and execution phases of JavaScript.
```js
function foo() {
  console.log("hello");
}

let foo = "hello";   // SyntaxError: foo already exist
```


**Example**
```javascript
let a = 'outer';

console.log(a);
setScope();
console.log(a);

var setScope = function () {
  a = 'inner';
};
```

Answer:
```plaintext
outer
Uncaught TypeError: setScope is not a function(…)
```

With hoisting, the above code is equivalent to:
```javascript
var setScope;

let a = 'outer';

console.log(a);
setScope();
console.log(a);

setScope = function () {
  a = 'inner';
};
```

Line 6 tries to call `setScope` as a function. However, `setScope` is just a declared global variable whose value is `undefined`. Note that unlike function declarations, with function expressions using `var`, the name of the function is hoisted, but not the function body.

[Back to Top](#section-links)


## Objects vs Primitive Values
Every value in JavaScript is either a primitive or an object.

Primitives are atomic values. They are not made up of other values nor can be broken down in any way.

Objects are "compound" values i.e. they are made up of other values: A single variable `a` below is assigned to an array, i.e. an object which holds 4 primitive values.
```javascript
let a = [1, 'Hello', null, undefined];
```

Primitive values are immutable.
```javascript
let word = 'hello';
let newWord = word.replace('h', 'j');

console.log(newWord); // 'jello'
```

```javascript
console.log(word); // 'hello'
```
While it looks like we have changed `'hello'` to `'jello`, what happens is `replace` returned a **new** string object and does not mutate the original string. Any operation that appears to change a primitive is actually returning a new value in JavaScript.


Objects are mutable. For example, the array is still the same but its content can be changed.
```javascript
let a = [1, 'Hello', true];
a[0] = 2;
a[1] = 'Goodbye';
a[2] = false;

console.log(a); // [2, 'Goodbye', false]
```

[Back to Top](#section-links)


## Variables as Pointers
We can think of variables as memory locations storing either a primitive value or a reference to an object depending on the type of value assigned.

### Working with Primitive Values
A variable assigned to a primitive value stores its **own copy** of the value at its own memory location. Hence, when we reassign `a` below, it affect only the value at `a` but not `b`. 
```js
let a = 1;
let b = a;

console.log(a);  // 1
console.log(b);  // 1

a = 3;
console.log(a);  // 3
console.log(b);  // 1
```
**Note:** Strings are the only primitives not stored directly in variables but it behaves the same way as other primitives.

### Working with Objects and Non-Mutating Operations
For a variable assigned to an object i.e. non-primitive value, it is the **reference to that object** rather that the object itself that is **stored at its memory location**.

**Some operations** applied on these variables are **non-mutating** on the objects they reference.
```node
// reassignment
> let c = [1, 2]
> let d = c
> c = [3, 4]
> c
= [ 3, 4 ]

> d
= [ 1, 2 ]
```

```node
> let c = [1, 2];
> let d = [3, 4];

> c.concat(d)
= [1, 2, 3, 4]

> c
= [1, 2]

> d
= [3, 4]
```
`concat` returns a **new array** with the elements of the caller and argument. It is non-mutating

**Other operations** on variable referencing objects are **mutating**:
```node
> let e = [1, 2]
> let f = e
> e.push(3, 4)
> e
= [ 1, 2, 3, 4 ]

> f
= [ 1, 2, 3, 4 ]
```
`push` inserts an additional element at the end of the array in-place.

```node
> let g = ['a', 'b', 'c']
> let h = g
> g[1] = 'x'
> g
= [ 'a', 'x', 'c' ]

> h
= [ 'a', 'x', 'c' ]
```
Although reassigning a specific element in the array doesnt not mutate the element, it mutates the array.

Whether an object referenced by a variable is mutated depends on the nature of the operation acting on it.

[Back to Top](#section-links)


## Pass by Reference vs Pass by Value
### What Pass-by-Value means?
The concept of "pass-by-value" means that a variable passed as argument **cannot have its value changed by the function call**. It will retain the same value after completion of the function call.

### What does Pass-by-Reference mean?
The concept of "pass-by-reference" meant that variables passed as arguments to a function **can have its values mutated** by the function call, depending on the nature of operations acting on it.

### What JavaScript Does
JavaScript cannot be labelled as purely "pass-by-value" or "pass-by-reference". It is both. Whether a function will modify a variable depends the following:
- If arguments are **primitive** values, they **cannot be modified** and can be simply understood as "pass-by-value"
	```js
	function cap(name) {
	  name.toUpperCase();
	}
	
	let myName = "naveed";
	cap(myName);
	console.log(myName); // => 'naveed'
	```

- If arguments are **objects**, they can be **both** "pass-by-value" or "pass-by-reference", depending on the operations used on them. If the arguments are acted on by **destructive** operations, they are **modified**. Otherwise, the arguments will not be changed.
	```js
	// concat is non-destructive and returns a new array
	function addName(arr, name) {
	  arr = arr.concat([name]);
	}
	
	let names = ["bob", "kim"];
	addName(names, "jim");
	console.log(names); // => [ 'bob', 'kim' ]
	```

	```js
	// push is destructive
	function addNames(arr, name) {
	  arr = arr.push(name);
	}
	
	let names = ["bob", "kim"];
	addNames(names, "jim");
	console.log(names); // => [ 'bob', 'kim', 'jim' ]
	```

[Back to Top](#section-links)


## Closures
- A closure is the combination of a **function and external variables (i.e. doesn't include parameters and local variables) used by the function**.
- Closures are **created** during function / method **definition**
- When the function is invoked, it **can access any variables** it needs from **that environment**, even if those variables are **not in the lexical scope at invocation**.
- A closure is not a snapshot of the program state. Each time the function is invoked, it see the **most recent values** of the variables in its envelope.
### Mental Model
- When we define a function, JavaScript will find all variable names it needs from the lexical scope that contains the function definition.
- It then places these names inside a special "envelope" object and attaches it to the function object. Each name in the envelope is a pointer to the original variable, not the value it contains.
- When a function encounters a variable name during execution, it first look for the name within its own local scope i.e. variables that are in scope in the function.
- If it cannot find the name, it then look inside the "envelope" to see if the variable name can be found there. If it is there, JavaScript can then follow the pointer and get the **current value** of the variable.
- See [illustration](https://karistobias.medium.com/javascript-closures-a-mental-model-66b7a9f02781)

```js
let numbers = [1, 2, 3];

function printNumbers() {
  console.log(numbers);
}

printNumbers(); // => [ 1, 2, 3 ]

numbers = [4, 5];
printNumbers(); // => [ 4, 5 ]
```

### Examples of Closures
```js
let counter = 0;

function incrementCounter() {
  counter += 1;
}

incrementCounter();
incrementCounter();
console.log(counter); // 2
```
While the above example can be explained using variable scope: a **function can access a variable in its surrounding scope**, external variable access is only possible **because the function definition forms a closure that includes the variables it needs from the outer scope** i.e. `counter`.  Thus, `incrementCounter` can access and update the `counter` variable.

```js
function makeCounter() {
  let counter = 0;

  return function() {
    counter += 1;
    return counter;
  }
}

let incrementCounter = makeCounter();
console.log(incrementCounter()); // 1
console.log(incrementCounter()); // 2
```
- Here, the closure formed between the anonymous function returned and the local variable `counter` make `counter` behave like a private variable since it cannot be accessed directly but can only be retrieved by calling the function. However, each call increments its value by `1`.

```js
let incrementCounter1 = makeCounter();
let incrementCounter2 = makeCounter();

console.log(incrementCounter1()); // 1
console.log(incrementCounter1()); // 2
console.log(incrementCounter1()); // 3

console.log(incrementCounter2()); // 1
console.log(incrementCounter2()); // 2

console.log(incrementCounter1()); // 4
```
- If we make multiple instances of the function, each will have its **own copy** of `counter`

```js
function makeCounter() {
  let counter = 0;

  const fun1 = function() {
    counter += 1;
    return counter;
  }

  const fun2 = function() {
    counter += 2;
    return counter;
  }

  return [fun1, fun2];
}

let funs = makeCounter();
let fun1 = funs[0];
let fun2 = funs[1];
console.log(fun1()); // 1
console.log(fun2()); // 3
```
- We can also have multiple functions form closure over the same `counter` variable.

```js
let oddNumbers = [];
array.forEach(number => {
  if (number % 2 === 1) {
    oddNumbers.push(number);
  }
});
```
- The callback function have access to `oddNumbers` because it forms a closure with the surrounding scope.

### Partial Function Application
Partial function application (partial application in short) is a function which **returns a function** that **calls a 3rd function** with **more arguments** than what the returned function requires. The arguments of the third (most nested) function are essentially supplied by the outer most function and first nested function at different invocation times.

```js
function add(first, second) {
  return first + second;
}

function makeAdder(firstNumber) {
  return function(secondNumber) {
	return add(firstNumber, secondNumber);
  };
}

let addFive = makeAdder(5);
let addTen = makeAdder(10);

console.log(addFive(3));  // 8
console.log(addFive(55)); // 60
console.log(addTen(3));   // 13
console.log(addTen(55));  // 65
```
- The `makeAdder` function is said to use **partial function application**. It returns an anonymous function with **one** parameter which in turns calls a 3rd function `add` with **two** arguments.
- When `makeAdder` is called, it applies some of the its arguments to the most nested function `add` (`firstName` in this case).
- When the returned function is called, it supplies the remaining arguments needed by the most nested function `add`.

Partial function application is most useful when we need to pass a function (**inner function with more arguments**) to another function (**returned wrapper function with less arguments**) that won't call the passed function with enough arguments.
```js
function download(locationOfFile, errorHandler) {
  // try to download the file
  if (gotError) {
	errorHandler(reasonCode);
  }
}

function errorDetected(url, reason) {
  // handle the error
}

download("https://example.com/foo.txt", /* ??? */);
```

```js
function makeErrorHandlerFor(locationOfFile) {
  return function(reason) {
	errorDetected(locationOfFile, reason);
  };
}

let url = "https://example.com/foo.txt";
download(url, makeErrorHandlerFor(url));
```
- We assume `download`, and `errorDetected` are external libraries and their definition is fixed.
- `makeErrorHandlerFor` function uses partial function application so that we can pass `errorDetected` to it and invoke it with only 1 argument `reason`.

### Recognizing Partial Function Application
Partial function application requires a **reduction in the number of arguments** we have to provide to the returned function to call the inner most function. If the number of arguments is not reduced, it isn't partial function application.

```js
function makeLogger(identifier) {
  return function(msg) {
    console.log(identifier + ' ' + msg);
  };
}
```
- This is not a partial function application as `log` also takes 1 argument while the returned function also expects 1 argument.

```js
function makeLogger(identifier) {
  return function(msg) {
    console.log(identifier, msg);
  };
}
```
- This is a partial function application as `log` takes 2 arguments while the returned function requires only 1 argument.

### What are Closures Good For?
- Callbacks
- Partial function application
- Creating private data
- Currying (a special form of partial function application)
- Emulating private methods
- Creating functions that can only be executed once
- Memoization (avoiding repetitive resource-intensive operations)
- Iterators and generators
- The module pattern (putting code and data into modules)
- Asynchronous operations

[Back to Top](#section-links)