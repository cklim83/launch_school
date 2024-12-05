## Section Links
[Douglas Crockford Lecture](#douglas-crockford-lecture)\
[JavaScript Style Guide](#javascript-style-guide)\
[Linters](#linters)\
[Strict Mode](#strict-mode)\
[Syntactic Sugar](#syntactic-sugar)\
[Errors](#errors)

---
## Douglas Crockford Lecture
[JavaScript Programming Language](https://www.youtube.com/watch?v=RO1Wnu-xKoY&t=2327s)
[JavaScript - The Good Parts](https://www.youtube.com/watch?v=hQVTIJBZook)

[Back to Top](#section-links)


## JavaScript Style Guide
[Airbnb JavaScript Style Guide](https://github.com/airbnb/javascript) offers widely adopted style suggestion for JavaScript code.

[Back to Top](#section-links)


## Linters
Linters inspect code for potential errors and for adherence to best practices determined by developers. It can identify stylistic, syntactic and procedural errors in code that deserve attention.

[ESLint](https://eslint.org/) is a Node package. Although it can be install globally using the `-g` option, a **local install** is recommended by the ESLint team. The following command will install ESLint and all related packages locally as a development dependency:
```terminal
$ npm install eslint@7.12.1 eslint-cli babel-eslint --save-dev
```
Version 7.12.1 of ESLint is currently recommended as later version are causing problems. We can ignore warning about `babel-eslint` as it is no longer receiving updates.

We can check the system find the correct version:
```terminal
$ npx eslint -v
v7.3.1
```

The `eslint` command takes a JavaScript file as argument

### Configuring ESLint
- Place the information in a file named `.eslintrc.yml`.
- When ESLint is run, it looks for this file in the current directory or closest parent directory for a usable configuration file.
- Put the `.eslintrc.yml` file in your top-level projects directory or in each individual project directory (if we want different configuration for each project), and not both.
- Use the following `.eslintrc.yml` file for all Launch school projects. They are not an exact match for rules described in AirBNB Style Guide though.
	```yaml
	# Last update: 04 Dec 2023
	root: true
	parser: babel-eslint
	parserOptions:
	  ecmaFeatures:
	    impliedStrict: true
	env:
	  browser: true
	  es6: true
	  jest: true
	  jquery: true
	  node: true
	extends:
	  - eslint:recommended
	globals:
	  alert: true
	  define: true
	  document: true
	  global: true
	  location: true
	  require: true
	  window: true
	  Handlebars: true
	  BigInt: true
	rules:
	  accessor-pairs: error
	  array-callback-return: error
	  arrow-spacing: error
	  block-scoped-var: error
	  brace-style:
	    - error
	    - 1tbs
	    - allowSingleLine: true
	  camelcase: error
	  complexity: error
	  consistent-return: error
	  constructor-super: error
	  eqeqeq: error
	  id-length:
	    - error
	    - exceptions:
	      - _
	      - a
	      - b
	      - x
	      - y
	      - z
	      min: 2
	      properties: never
	  indent:
	    - error
	    - 2
	    - SwitchCase: 1
	  keyword-spacing: error
	  linebreak-style: error
	  max-depth: error
	  max-len:
	    - error
	    - code: 80
	      tabWidth: 2
	      ignoreRegExpLiterals: false
	      ignoreStrings: true
	      ignoreTemplateLiterals: true
	      ignoreTrailingComments: true
	      ignoreUrls: true
	  max-lines-per-function:
	    - error
	    - max: 20
	      skipBlankLines: true
	      skipComments: true
	  max-nested-callbacks:
	    - error
	    - max: 4
	  max-statements:
	    - error
	    - max: 15
	    - ignoreTopLevelFunctions: true
	  max-statements-per-line: error
	  new-parens: error
	  no-array-constructor: error
	  no-async-promise-executor: error
	  no-bitwise: error
	  no-buffer-constructor: error
	  no-caller: error
	  no-class-assign: error
	  no-confusing-arrow:
	    - error
	    - allowParens: true
	  no-console: 'off'
	  no-const-assign: error
	  no-constant-condition:
	    - error
	    - checkLoops: false
	  no-debugger: 'off'
	  no-dupe-class-members: error
	  no-duplicate-imports: error
	  no-eq-null: error
	  no-eval: error
	  no-extend-native: error
	  no-implicit-globals: error
	  no-implied-eval: error
	  no-inner-declarations:
	    - error
	    - both
	  no-iterator: error
	  no-label-var: error
	  no-lonely-if: error
	  no-loop-func: error
	  no-misleading-character-class: error
	  no-mixed-operators: error
	  no-multi-assign: error
	  no-multi-str: error
	  no-multiple-empty-lines: error
	  no-nested-ternary: error
	  no-new: error
	  no-new-func: error
	  no-new-object: error
	  no-new-require: error
	  no-new-symbol: error
	  no-new-wrappers: error
	  no-octal-escape: error
	  no-process-env: error
	  no-process-exit: error
	  no-prototype-builtins: 'off'
	  no-restricted-syntax:
	    - error
	    - message: Do not use `with` statement.
	      selector: WithStatement
	  no-return-assign: error
	  no-return-await: error
	  no-script-url: error
	  no-self-assign:
	    - error
	    - props: true
	  no-self-compare: error
	  no-sequences: error
	  no-shadow-restricted-names: error
	  no-tabs: error
	  no-template-curly-in-string: error
	  no-this-before-super: error
	  no-throw-literal: error
	  no-trailing-spaces: error
	  no-unmodified-loop-condition: error
	  no-unneeded-ternary: error
	  no-unused-expressions: error
	  no-unused-vars:
	    - error
	    - args: all
	      argsIgnorePattern: "^_"
	      caughtErrors: all
	      caughtErrorsIgnorePattern: "^_"
	      vars: local
	  no-use-before-define:
	    - error
	    - functions: false
	  no-useless-call: error
	  no-useless-catch: error
	  no-useless-computed-key: error
	  no-useless-rename: error
	  no-useless-return: error
	  no-with: error
	  nonblock-statement-body-position: error
	  one-var-declaration-per-line: error
	  operator-assignment: error
	  prefer-promise-reject-errors: error
	  quote-props:
	    - error
	    - consistent-as-needed
	  radix: error
	  require-await: error
	  require-yield: error
	  semi:
	    - error
	    - always
	    - omitLastInOneLineBlock: true
	  semi-spacing: error
	  semi-style: error
	  space-before-blocks: error
	  space-infix-ops: error
	  space-unary-ops:
	    - error
	    - words: true
	      nonwords: false
	  vars-on-top: error
	```

- Create a `hello.js` file
	```js
	console.log(helloWorld)
	```

- Next run ESLint on file. Sample output could be:
	```terminal
	$ npx eslint hello.js
	
	/Users/wolfy/hello.js
	  1:13  error  'helloWorld' is not defined  no-undef
	  1:24  error  Missing semicolon            semi
	
	✖ 2 problems (2 errors, 0 warnings)
	  1 error and 0 warnings potentially fixable with the `--fix` option.
	```

- ESLint is available in most code editors as a plugin. That is the most convenient way to use it.

[Back to Top](#section-links)


## Strict Mode
JavaScript ES5 introduced **strict mode**, an optional mode that modifies the semantics of JavaScript and prevent certain kinds of errors and syntax.
- Strict mode eliminates some silent errors that occur in sloppy mode by changing them to throw errors. Silent errors occur when a program does something **unintended** but continue to run as though nothing is wrong. 
- Strict mode prevents some code that can inhibit JavaScript's ability to optimize a program to allow it to run faster.
- Strict mode prohibits using names and syntax that may conflict with future versions of JavaScript.

### Enable Strict Mode
Strict mode can be enabled at **global** or **individual function** level. To turn it on at global level, include the following **pragma** at the start of the program.
```js
"use strict";

// The rest of the program. Everything from here to the end of
// the file runs in strict mode.

function foo() {
  // strict mode is enabled here too.
}

// Strict mode is still enabled
foo();
```

To enable it at a local function level, use it at the start of that function definition:
```js
function foo() {
  'use strict';

  // The rest of the function. Everything from here to the end of
  // the function runs in strict mode.
}

// Strict mode is disabled unless you defined it globally.
foo();
```

Once enabled, we cannot disable strict mode later.

### Errors Raised by Strict Mode
**Implicit Global Variables**
```js
"use strict";

function foo() {
  bar = 3.1415; // ReferenceError: bar is not defined
}

foo();
console.log(bar);
```
- In sloppy mode, bar will have been made a global variable with no error raised.

**Leading Zeros**
```js
"use strict";

console.log(1234567);   // 1234567
console.log(0);         // This is okay
console.log(0.123);     // So is this
console.log(-0.123);    // So is this
console.log(01234567);  // SyntaxError: Octal literals are not allowed in strict mode.
console.log(089);       // SyntaxError: Decimals with leading zeros are not allowed in strict mode.
console.log(01.23);     // SyntaxError: missing ) after argument list
console.log(-01234567); // SyntaxError: Octal literals are not allowed in strict mode.
console.log(-089);      // SyntaxError: Decimals with leading zeros are not allowed in strict mode.
console.log(-01.23);    // SyntaxError: missing ) after argument list
```
- In sloppy mode, an integer with leading `0` but doesn't contain `8` or `9` is interpreted as an octal number. This is undesirable and may lead to undesirable results.
- In strict mode, any numbers that look like octal raise an error. It also prevent number literals from beginning with `0` except for `0` itself.

**Other Strict Mode Differences**
Strict mode also:
- prevents declaring two function parameters with same name.
- prevents using newer reserved keywords such as `let` and `static` as variable names.
- prevents you from using `delete` operator on a variable name.
- forbids binding of `eval` and `arguments` in any way.
- disables access to some properties of `arguments` object in functions
- disables the `with` statement, whose use is not recommended even in sloppy mode.
### When to Use Strict Mode
- Use it in any new code that you write.
- When adding new functions to old codebase, it is safe to use function-level strict mode to new function. If no new functions are to be created in old codebase, strict mode shouldn't be used.

[Back to Top](#section-links)


## Syntactic Sugar

### Concise Property Initializers
To initialize an object from variables using the same name. The classic syntax is:
```js
function xyzzy(foo, bar, qux) {
  return {
    foo: foo,
    bar: bar,
    qux: qux,
  };
}
```

A more concise way is:
```js
function xyzzy(foo, bar, qux) {
  return {
    foo,
    bar,
    qux,
  };
}
```
- Using the name of the property we want to initialize, JavaScript will look for the variable with same name to use as the initial value.

We can even mix the concise notation with ordinary initializers:
```js
function xyzzy(foo, bar, qux) {
  return {
    foo,
    bar,
    answer: qux,
  };
}
```

### Concise Methods
Classic Syntax:
```js
let obj = {
  foo: function() {
    // do something
  },

  bar: function(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}
```

Concise syntax allows use to do without `: function`:
```js
let obj = {
  foo() {
    // do something
  },

  bar(arg1, arg2) {
    // do something else with arg1 and arg2
  },
}
```

### Object Destructuring
A shorthand syntax to do multiple assignments in a single expression.

Classic Way:
```js
let obj = {
  foo: "foo",
  bar: "bar",
  qux: 42,
};

let foo = obj.foo;
let bar = obj.bar;
let qux = obj.qux;
```

Equivalent shorthand:
```js
let { foo, bar, qux } = obj;
```

The order of names in braces is actually unimportant. Below code works as well:
```js
let { qux, foo, bar } = obj;
```

You can omit any names that you don't need:
```js
let { foo } = obj;
let { bar, qux } = obj;
```

You can even use different names for the result:
```js
let { qux: myQux, foo, bar } = obj;
```
- In this example, we create a variable `myQux` which is assigned the value of `obj.qux`.

To use destructuring outside of variable initialization, we need to enclose the expression in parentheses:
```js
// { foo, bar, qux } = obj; generate a syntax error
({ foo, bar, qux } = obj);
```

Destructuring also works with function parameters:
```js
function xyzzy({ foo, bar, qux }) {
  console.log(qux); // 3
  console.log(bar); // 2
  console.log(foo); // 1
}

let obj = {
  foo: 1,
  bar: 2,
  qux: 3,
};

xyzzy(obj);
```
- the function's definition uses destructuring to pull out the needed properties and store them in local variables.

### Array Destructuring
Destructuring also works with arrays:
```js
let foo = [1, 2, 3];
let [ first, second, third ] = foo;
```

is equivalent to the following:
```js
let foo = [1, 2, 3];
let first = foo[0];
let second = foo[1];
let third = foo[2];
```

You can skip elements if not all are needed:
```js
let bar = [1, 2, 3, 4, 5, 6, 7];
let [ first, , , fourth, fifth, , seventh ] = bar;
```

Array destructuring is also useful for swapping values:
```js
let one = 1;
let two = 2;

[ one, two ] =  [two, one];

console.log(one);   // 2
console.log(two);   // 1
```

Rest syntax can be used in array destructuring to assign a variable to the rest of an array:
```js
let foo = [1, 2, 3, 4];
let [ bar, ...qux ] = foo;
console.log(bar);   // 1
console.log(qux);   // [2, 3, 4]
```

### Spread Syntax
Spread syntax uses `...` to "spread" the elements of an array or object into separate items.

Classic Code:
```js
function add3(item1, item2, item3) {
  return item1 + item2 + item3;
}

let foo = [3, 7, 11];
add3(foo[0], foo[1], foo[2]); // => 21
```

Spread Syntax:
```js
add3(...foo); // => 21
```

Common use-cases for spread syntax:
```js
// Create a clone of an array
let foo = [1, 2, 3];
let bar = [...foo];
console.log(bar);         // [1, 2, 3]
console.log(foo === bar); // false -- bar is a new array
```

```js
// Concatenate arrays
let foo = [1, 2, 3];
let bar = [4, 5, 6];
let qux = [...foo, ...bar];
qux;  // => [1, 2, 3, 4, 5, 6]
```

```js
// Insert an array into another array
let foo = [1, 2, 3]
let bar = [...foo, 4, 5, 6, ...foo];
bar; // => [1, 2, 3, 4, 5, 6, 1, 2, 3]
```

Spread syntax also work with objects:
```js
// Create a clone of an object
let foo = { qux: 1, baz: 2 };
let bar = { ...foo };
console.log(bar);         // { qux: 1, baz: 2 }
console.log(foo === bar); // false -- bar is a new object
```

```js
// Merge objects
let foo = { qux: 1, baz: 2 };
let xyz = { baz: 3, sup: 4 };
let obj = { ...foo, ...xyz };
obj;  // => { qux: 1, baz: 3, sup: 4 }
```

Note: spread syntax with objects only return properties that `Object.keys` would return i.e. it only returns enumerable "own" properties. It is not the right choice is we need to duplicate objects that inherit from another object.

### Rest Syntax
Rest syntax can be though of as the opposite of spread syntax: it gathers / collect multiple items into an array or object. The rest element must be the **last item** in any expression that uses rest syntax.
```js
let foo = [1, 2, 3, 4];
let [ bar, ...otherStuff ] = foo;
console.log(bar);        // 1
console.log(otherStuff); // [2, 3, 4]
```
- Here `...otherStuff` uses rest syntax to collect remaining elements of `foo` into a new array called `otherStuff`.

Rest syntax also works with objects:
```js
let foo = {bar: 1, qux: 2, baz: 3, xyz: 4};
let { bar, baz, ...otherStuff } = foo;
console.log(bar);        // 1
console.log(baz);        // 3
console.log(otherStuff); // {qux: 2, xyz: 4}
```

Rest syntax is often used in functions, in favour over using `arguments`.
```js
function maxItem() {
  let maximum = arguments[0];
  [].forEach.call(arguments, value => {
    if (value > maximum) {
      maximum = value;
    }
  });

  return maximum;
}

console.log(maxItem(2, 6, 10, 4, -3));
```
- Although this works, the lack of a parameter list in `maxItem` hurts code readability.
- As `arguments` is not an array, `[].forEach.call` is used to iterate over the arguments. We can also use the `for` loop.

Rest syntax can achieve the same result with clearer code:
```js
function maxItem(first, ...moreArgs) {
  let maximum = first;
  moreArgs.forEach(value => {
    if (value > maximum) {
      maximum = value;
    }
  });

  return maximum;
}

console.log(maxItem(2, 6, 10, 4, -3));
```

[Back to Top](#section-links)


## Errors
A **`ReferenceError`** occurs when you attempt to use a variable of function that doesn't exist.
```javascript
a;    // Referencing a variable that doesn't exist results in a ReferenceError.
a();  // The same is true of attempting to call a function that doesn't exist.
```

A **`TypeError`** occurs when you try to access a non-existence property on a value such as `null`.  Trying to call something that is not a function can also raise a `TypeError`.
```javascript
var a;      // a is declared but is empty, as it has not been set to a value.
typeof(a);  // "undefined"

a.name;     // TypeError: Cannot read property 'name' of undefined

a = 1;
a();        // TypeError: Property 'a' is not a function
```

A **`SyntaxError`** is one that is usually detected by the compiler/interpreter and occurs before runtime.
```javascript
function ( {}                   // SyntaxError: Unexpected token (
```

Some syntax errors can occur during runtime.
```javascript
JSON.parse('not really JSON');  // SyntaxError: Unexpected token i in JSON at position 0
```

### Preventing Errors
```javascript
function lowerInitial(word) {
  return word[0].toLowerCase();
}
```

```javascript
lowerInitial('');       // TypeError: Cannot read property 'toLowerCase' of undefined
```

A **guard clause** i.e. code to guarantee data meets certain pre-conditions, can be use to prevent errors. We use them when we cannot trust the inputs will be always valid.
```javascript
function lowerInitial(word) {
  if (word.length === 0) {       // If word contains an empty String,
    return '-';                  // return a dash instead of proceeding.
  }

  return word[0].toLowerCase();  // word is guaranteed to have at least
}                                // 1 character, so word[0] never evaluates
                                 // as undefined.
```

You can also identify edge cases that can break your program and where certain assumptions might not hold true.

When writing code, we can think of the common use cases of a new function, then check how your function handles them. We can then detect edge cases from there.

### Catching Errors
The `try`, `catch` and `finally` construct can be use to handle errors gracefully. The `finally` clause is optional.
```javascript
try {
  // Do something that might fail here and throw an Error.
} catch (error) {
  // This code only runs if something in the try clause throws an Error.
  // "error" contains the Error object.
} finally {
  // This code always runs, no matter if the above code throws an Error or not.
}
```

```javascript
function parseJSON(data) {
  let result;

  try {
    result = JSON.parse(data);  // Throws an Error if "data" is invalid
  } catch (e) {
    // We run this code if JSON.parse throws an Error
    // "e" contains an Error object that we can inspect and use.
    console.log('There was a', e.name, 'parsing JSON data:', e.message);
    result = null;
  } finally {
    // This code runs whether `JSON.parse` succeeds or fails.
    console.log('Finished parsing data.');
  }

  return result;
}

let data = 'not valid JSON';

parseJSON(data);    // Logs "There was a SyntaxError parsing JSON data:
                    //       Unexpected token i in JSON at position 0"
                    // Logs "Finished parsing data."
                    // Returns null
```

Use `try/catch/finally` blocks when:
- A method can throw an Error and you need to handle or prevent that Error,
- A simple guard clause cannot prevent that Error.

[Back to Top](#section-links)