## Section Links
[Introduction](#introduction)\
[Brief History of JavaScript](#brief-history-of-javascript)\
[JavaScript Versions](#javascript-versions)\
[Abstraction Layers of JavaScript (jQuery and React)](#abstraction-layers-of-javascript-jquery-and-react)\
[Runtime Environments](#runtime-environmens)\
[Running JavaScript Code](#running-javascript-code)\
[Style Guide](#style-guide)\
[References](#references)

---
## Introduction
- JavaScript is an **object-based** scripting language for developing client and server Internet applications. Together with HTML and CSS, it is part of a layer cake of standard web technologies that enables developers to create complex features on web pages ranging from dynamically updating content, interact with multimedia and animate images etc.

[Back to Top](#section-links)


## Brief History of JavaScript
- JavaScript was created by Brendan Eich at Netscape for use in its flagship web browser.
- In 2008, Google released open-source Chrome V8, a high performance Javascript engine. Subsequent proliferation of fast Javascript engines made it possible to develop sophisticated browser based applications comparable to desktop and mobile.
- Release of the open-source, cross-platform environment `Node.js` by Ryan Dahl made it possible to run JavaScript code **outside a browser**. Today, Javascript is used to write all kinds of applications, including browser, server, mobile and desktop applications.

[Back to Top](#section-links)


## JavaScript Versions
- JavaScript, aka ECMA Script, has a long development history. The first JavaScript standard, ECMAScript 1, was released in 1997.  Since than, it has many [released versions](https://en.wikipedia.org/wiki/ECMAScript_version_history#cite_note-1) and is now a more robust, secure and expressive language. As of Jun 2023, the latest version is ECMA Script 2023 (ECMAScript version14 or ES14 in short).
- Version ECMAScript 2015 (ES6) represents a quantum leap in capabilities compared to prior versions. It was heralded as the start of modern JavaScript. Subsequent versions are thus broadly known as ES6+.
- Due to constantly evolving features, not all browsers support all the latest features.  Hence, you should refer to the [compatibility table](https://compat-table.github.io/compat-table/es6/) to ensure new features you intend to use are supported by browsers used by your target audience before using them. Tools like [Babel](https://babeljs.io/) can also be used to transpile ES6+ code so that they run in browsers that don't yet fully support those features.
- In general, Google Chrome has the best support for modern features of JavaScript, followed by Firefox. Microsoft browsers tend to be the last to provide full support. Mobile device support is good although some features may be lacking.
- There are still substantial old codebases based on ES5 code (published in 2009) in use. Thus, you will need to be familiar with both modern and traditional JavaScript until those code are transited.

[Back to Top](#section-links)


## Abstraction Layers of JavaScript (jQuery and React)
- Abstraction in programming allows a software user to use third-party libraries/software without needing to know how things work under the hood. 
- Abstraction can operate across layers, with lower level layers providing service to higher level layers:
	- For example, programmers operate at a lower level of abstraction than the application user. They use programming languages like JavaScript to build the functionalities of an application. The written code are in turn processed in a runtime environment (aka engine) written in another lower level language like C++. These engines convert the JavaScript code to lower level codes and eventually to binaries before they can be executed by a machine.
- jQuery (library) and React (Framework) are higher level abstractions built on top of JavaScript.
- Understanding lower levels of abstraction will help one make better use of tools at a higher abstraction level. Hence, it is important to have a good grounding in JavaScript.

[Back to Top](#section-links)


## Runtime Environments
- A runtime environment is an execution environment that allows an application to access system resources (e.g. RAM, sensors, networking hardware) and provide the application with tools it need to operate.
- These tools may let the application interact with the outside world, work with operating system or translate the application instruction into something that performs actual work.
- Components of a runtime environment:
	- Operating System Application Programming Interfaces (API) for access to system resources. 
	- Compilers/Interpreters typically provide a layer of abstraction over these OS API
	- Compilers/Interpreters will then translate the code into a form that can be executed
	- Developer tools for debugging and profiling code are also treated as part of the runtime environment
- In JavaScript, the two major runtime environments are the browser and `Node.js`

### Browser
- The web browser was the original JavaScript runtime environment. Almost all browsers have a JavaScript engine built into it.
- JavaScript was used in browser to:
	- Programmatically alter web pages based on user action. To do this, it relies on the DOM (Document Object Model) API to manipulate the structure and appearance of a webpage
	- Exchange messages with a server over a network. The XHR (XMLHttpRequest) interface and Fetch API enables this.
- Browsers also provide "Developer Tools" which include a REPL, a debugger, a network inspector, performance profiler etc.

### `Node.js`
- `Node.js` is a runtime environment that turns JavaScript into a general purpose programming language that can run applications on almost any system.
- Creators of `Node.js` added API and tools to the Chrome V8 JavaScript engine for desktop and server computing.
- A general-purpose programming environment, like `Node.js`, needs the following minimal capabilities:
	- The ability to read and write disk files (disk I/O);
	- The ability to read and write via the terminal (standard I/O);
	- The ability to send and receive messages over a network (network I/O);
	- The ability to interact with a database.
- `Node.js` also provides an interactive REPL to execute JavaScript code, tools for debugging and inspecting programs at runtime. The latter two are however harder to use directly so we generally use a browser.
- `npm` is the package manager of `Node.js`

[Back to Top](#section-links)


## Running JavaScript Code
### Running JavaScript From Command Line Using Node
- We can run JavaScript code line by line in the REPL environment of Node using the `node` command
```terminal
node
Welcome to Node.js v20.5.0.
Type ".help" for more information.
> console.log('Hello, world!')
Hello, world!
undefined
```
- We can also run an JavaScript code housed in a file in the command line
```shell
$ node example.js # assume contains console.log('Hello');
Hello
```
- We can use `control + c` to force abort a running program.

### Running JavaScript in the Browser
- JavaScript code are embedded in script tags just before the closing `<body>` tag in a html file.
- The first way to run JavaScript code is to put the code in a file, then reference it using the `src` attribute of a script tag. This tells the browser to load JavaScript from a file named `example.js`. The code executes when the browser loads the file and display the JavaScript output in the console under Chrome's developer tools.
	```html
	<!DOCTYPE html>
	<html>
	  <head>
	    <title>Document</title>
	  </head>
	  <body>
	    <script src="example.js"></script>
	  </body>
	</html>
	```
- Alternatively, we can also directly embed JavaScript code within the script tag.
	```html
	<!DOCTYPE html>
	<html>
	  <head>
	    <title>Document</title>
	  </head>
	  <body>
	    <script>
	      console.log("Hello, world!");
	    </script>
	  </body>
	</html>
	```
- Avoid using both methods. If the `src` attribute of a script tag is specified, there should be no embedded JavaScript code. If **both exists**, only JavaScript code from file is executed.
[Back to Top](#section-links)


## Style Guide
### Naming Conventions
- Use **camelCase** formatting for **most variable and function names**, with the first character a **lowercase letter**.
	```js
	let answerToUltimateQuestion = 42;     // initializing a variable
	function fourScoreAndSevenYearsAgo() { // defining a function
	  // do something
	}
	```
- Use **CamelCase** (first letter capitalized) aka **PascalCase** for **constructor function names**. Constructor functions are functions used to create a type.
	```js
	function DomesticCat(name) {           // defining a function
	  // do something
	}
	```
- Use **SCREAMING_SNAKE_CASE** i.e. uppercase names with underscores for **constants** that store **unchanging configuration values** or **magic numbers**. 
	```js
	// Configuration Values
	const INTEREST_RATE = 0.0525;
	const COURSE_NUMBER = 'JS101';
	const HOST = 'launchschool.com';
	const FIRST_LETTER = 'a';             // magic number
	const LAST_LETTER = 'z';              //
	```

- A magic number is a number (or other simple value) that appears in the program without any information that describes what that number represents e.g. number of cards on hand for each player in a game.
	```js
	// Magic Numbers
	const SECONDS_PER_MINUTE = 60;
	const OUNCES_PER_POUND = 16;
	const METERS_PER_KILOMETER = 1000;
	const PI = 3.141592;
	const INPUT_PROMPT = '==>';
	const TODAY = new Date();
	const CARDS_TO_DEAL = 5;
	```

- When declaring constants, we should find ways to clarify the meaning of number where possible:
	```js
	// Okay
	const FIRST_CHARACTER_CODE = 97;
	const LAST_CHARACTER_CODE = 122;
	
	// Better
	const FIRST_CHARACTER_CODE = 'a'.charCodeAt();
	const LAST_CHARACTER_CODE = 'z'.charCodeAt();
	```

- **Constants used to store functions** should follow the same rules as function names: use camelCase for most functions, and PascalCase for constructor functions.
	```js
	const sayHi = function() {
	  console.log("Hi!");
	};
	
	const Pet = function(name) {
	  this.name = name;
	};
	```
- For **all other constants**, the rules are much more flexible. You may use camelCase, PascalCase, or even SCREAMING_SNAKE_CASE. Use your personal preferences and any guidelines laid out by your teammates to choose your style.
	```js
	const greetings = `Hi! How are you today?`;
	const DeleteAllTodoLists = "DELETE FROM todolists";
	const FIND_TODOLIST = `SELECT * FROM todolists WHERE id = ${id}`;
	```

- All names i.e. variables, constants and functions, should use the alphabetic and numeric characters only, though SCREAMING_SNAKE_CASE names may use underscores as well. The first character must be alphabetic. Do not use consecutive underscores nor should you use names with underscores at the start or end of the name.

#### Examples
Names that follow these naming conventions are called idiomatic names.
##### Idiomatic names
|Category|Name|Notes|
|---|---|---|
|Non-constant variables and object properties|`employee`||
||`number`||
||`fizzBuzz`||
||`speedOfLight`||
||`destinationURL`|URL is an acronym|
||`m00n`||
|Constructor functions and classes|`Cat`||
||`BoxTurtle`||
||`FlightlessBird`||
|Other functions|`parseURL`|URL is an acronym|
||`goFaster`||
|Configuration and magic constants|`ABSOLUTE_PATH`||
||`TODAY`||
|Other `const` names|`employeeOfMonth`|Local style|
||`HairyCat`|Local style|
||`ABSOLUTE_PATH`|Local style|

##### Valid but Non-Idiomatic Names
|Category|Name|Notes|
|---|---|---|
|Universally non-idiomatic|`$number`|Begins with $|
||`fizz_buzz`|snake_case not allowed|
||`fizzBUZZ`|BUZZ is not an acronym|
||`_hello`|Begins with `_`|
||`goodbye_`|Ends with `_`|
||`milesperhour`|Undifferentiated words|
||`MILESPERHOUR`|Undifferentiated words|
|Non-constant variables and object properties|`Employee`|Begins with capital letter|
||`fizzBUZZ`|BUZZ is not an acronym|
||`FIZZ_BUZZ`|SCREAMING_SNAKE_CASE|
|Constructor functions and classes|`cat`|Begins with lowercase letter|
||`makeTurtle`|Begins with lowercase letter|
||`FIZZ_BUZZ`|SCREAMING_SNAKE_CASE|
|Other functions|`ParseURL`|Begins with capital letter|
||`FIZZ_BUZZ`|SCREAMING_SNAKE_CASE|
|Configuration and magic constants|`absolutePath`|Not SCREAMING_SNAKE_CASE|
||`Today`|Not SCREAMING_SNAKE_CASE|
**Non-idiomatic names** are commonly used by **external libraries** to provide names that are easy to type and **avoids conflict with names in other libraries**. For instance, the jQuery library uses a function named `$` as well as variables whose name begins with `$`, while the underscore.js library leans heavily on a variable named `_`

##### Invalid Names
|Name|Notes|
|---|---|
|42ndStreet|Begins with number|
|fizz-buzz|Hyphen not allowed|
|fizz.buzz|Looks like property reference|

### Formatting
- **Indention**: Use 2 space characters, not tabs
- **Line Length**: Limit lines to 80 characters
- **Single line comment**: Use `//` to mark the start of a comment. Such comment run through the end of the line.
	```js
	let answerToUltimateQuestion = 42; // initializing a variable
	let aRoundNumber = 3.141592;       // another comment
	```
- **Multi-line comments**: Use `/*` and `*/` when you want to embed comments in middle of a line.
	```js
	/* This is a multi-line comment.
	   It can span any number of lines.
	   The command ends when you see
	   an * followed by a / as shown
	   here ==> */
	
	// You can also use /* and */ to embed comments in the middle of a line:
	let area = w /* width */ * h /* height */;
	// You should avoid embedded comments
	```
- **Curly braces**: The **opening brace** for code block or function body should be on the **same line** as the function name or conditional expression, separated with a **single space**. The closing brace should be on its own line.
	```js
	if (isOk()){              // bad
	  // do something
	}
	
	if (isOk())               // bad
	{
	  // do something
	}
	
	if (isOk()) {             // good
	  // do something
	}
	```

- **Spaces**: `if`, `for` and `while` statements should have spaces between the keywords and the following opening parenthesis, and between closing parenthesis and opening brace. We should also place space before and after operators and equals symbols.
	```javascript
	// Bad
	let counter=0;
	while(counter<15){
	  counter+=1;
	}
	
	// Good
	let counter = 0;
	while (counter < 15) {
	  counter += 1;
	}
	```

	```js
	let sum=x+5;              // bad
	let sum = x + 5;          // good
	```
	
- **Semicolons**: Always terminate each statement with a `;` unless the line ends with `{`, `}`, or `:`. 
	```js
	let x = 3;
	let y = 5;
	
	if (x === y) {
	  console.log("x is equal to y");
	} else {
	  console.log("x is not equal to y");
	}
	```

	Since JavaScript automatically but **invisibly inserts** semicolons where it needs them, we can also see code with semicolons totally omitted. This is also the reason why semicolons are not needed in REPL. However this style is discouraged in outside REPL because the auto-insertion mechanism can interpret the code differently from what we intended and placed it at a wrong location, causing an error.
	```js
	let x = 3
	let y = 5
	
	if (x === y) {
	  console.log("x is equal to y")
	} else {
	  console.log("x is not equal to y")
	}
	```

- **let**: Use one let declaration per variable. It avoids thinking about whether to swap out a `;` for a `,`.
	```javascript
	// Bad
	let firstName = 'Shane',
	    lastName = 'Riley',
	    dogs = ['Josie', 'Libby'];
	
	// Good
	let firstName = 'Shane';
	let lastName = 'Riley';
	let dogs = ['Josie', 'Libby'];
	```

[Back to Top](#section-links)


## References
- The official documentation can be found at [ECMA International](https://www.ecma-international.org/publications-and-standards/standards/ecma-262/).
- [Introduction to Programming with JavaScript](https://launchschool.com/books/javascript) by launch school provides a good introduction.
- [JavaScript documentation on Mozilla Developer Network(MDN)](https://developer.mozilla.org/en-US/docs/Web/JavaScript) is also a great reference. Best way to find MDN references is to include "MDN" as part of the google search term e.g. "MDN String". We can add JavaScript to the search query for results to be more specific.

[Back to Top](#section-links)