# Approach To Small Coding Problems

## Characteristics of Small Coding Problems
- Problems that take approximately **20 - 45 minutes** to solve using **10 - 40 lines of code**
- Test candidates on:
	- Logic and reasoning
	- Mastery of a language
	- Communication skills
- Used extensively in screening interviews to filter candidates for hiring managers
- Tested skills require a lot of **consistent practice** and are not something one can "acquire and file away"


## \[P\] Understand the Problem
This step involves 1 or more of following:
1. Explicit requirements
    - Notes should be taken to translate written descriptions and test examples to shorter (point form) and clearer requirements
    
2. Implicit requirements
    - Requirements that to be modelled/inferred/clarified 
	
	**Example: Given an input integer `n`, print a diamond with the center width of `n` \*s.** 
    ```terminal
    # n = 5
    # required output
      *
	 ***
	*****
	 ***
	  *
	```
    - Modelled requirements
		- star_rows = `[1, 3, ..., 2a+1, ... 3, 1]`
		- prepend_space_rows = `[a, a-1, ... 0, ... a-1,  a]`
	- Inferred requirements
		- n cannot be negative
	- Clarifications
		- Is minimum n == 1?
		- Can n be even?
		- Should method return a multi-line string or output the pattern
 
3. Implicit knowledge
    - These have to be captured and onverted to explicit rules in computational language
   
   **Example: [Writing Ordinal Numbers](https://www.britannica.com/dictionary/eb/qa/How-To-Write-Ordinal-Numbers)**
	```ruby
	first        1st
	second       2nd
	third        3rd
	fourth       4th
	fifth        5th
	sixth        6th
	seventh      7th
	eighth       8th
	ninth        9th
	tenth        10th
	eleventh     11th
	twelfth      12th
	thirteenth   13th
	fourteenth   14th
	fifteenth    15th
	sixteenth    16th
	seventeenth  17th
	eighteenth   18th
	nineteenth   19th
	twentieth    20th
	```
	Becomes the following rule:
	
	|Number| Suffix|
	|---|---|
	| `4..20` | 'th' |
	| `1, 21, 31, ...` | 'st' |
	| `2, 22, 32, ...` | 'nd' |
	| `3, 23, 33, ...` | 'rd' |
	| others | 'th' |

4. Identify and define new terms and concepts in problem domain
	
	**Example: Chess Queen's Move**
	
	| Term | Meaning|
	|---|---|
	| Vertical | Same column in 8 by 8 board |
	| Horizontal | Same row in 8 by 8 board |
	| Diagonal | abs(row_1 - row_2) == abs(col_1 - col_2) |
  
5. Asking questions to verify your understanding
	- Will we expect a particular input, range of values? Do we need to validate inputs?
	- What happen when `null`, empty or edge inputs are given? What should our program return?


## \[E\] Examples / Test Cases
Test cases serve two purposes:
	- help us understand the problem in terms of input -> output
    - allow us to verify our algorithm and solution
  
We should consider the following test cases:
- Edge cases from input perspective
	- emptiness (`nil`, `""`, `[]`, `{}`)
    - boundary conditions based on applicable range of values
    - tolerance, rounding errors
    - repetition / duplication
    - data types
  
 - Failures / Bad Input
    - Should exceptions be raised, errors be reported?
    - Should we return a special value (`nil`/`null`, `0`, `""`, `[]` etc)?
  
 Always ask questions to verify understanding


## \[D\] Data Structure
Data structure is not referring to the data type of input and output. Rather, it is the data type of intermediary(ies) that will help us convert from input to output more easily and efficiently.
  
  
When considering what data structures to use, the 4 standard Ruby data types and their public methods are the building blocks for our solution:
- **String**: if data processing steps involves string manipulation using one of the following methods:
	- `concat`, `strip`, `reverse`, `split`, `replace` ...
	- Regular expressions, matching ...
		
- **array**: if we need to iterate members of a collection, use their index, transform, select or agglomerate results. We can use abstractions like:
	- `map`, `reduce`, `select`, `all` etc  

- **hash**: if we need to use a lookup table or dictionary to capture certain rules or to partition data for more efficient search and access.

- **number**: if we need to perform certain mathematic operations. Sometimes, using numbers as string may confer certain advantages (e.g. splitting into digits for map transformations or change of base manipulation)

- **compound data structures** : nested array or hash with array/object values may be useful in certain context e.g. modeling a n-dimensional board etc.


## \[A\] Algorithm
Algorithm should be viewed **in conjunction** with data structures selected in previous steps in the solution development: the choice of data structures selected will determine the methods available to help solve the problem. Hence it is imperative we **describe the solution using the language of chosen data structure**. 
- e.g. if we chose to store a series of strings in an array and want them in a certain order, we could describe it as such: "sort words by their length". This help later in the translation to code since `Array#sort_by` is a method available to our chosen data structure. This description immediate allow us to map to `words.sort_by { |word| word.length }`

- It is very important we rely on the language built-in abstractions as they form the building blocks of our solutions (without the need to reinvent the wheel). We should be very fluent with below methods:
	- String / Regex
    - Array
      - Ruby: Enumerable
      - JavaScript: Higher Order Functions
    - Hash / Object
      - Creation (default values)
      - Access (default values)
      - Iteration

- We should avoid solving big problems but break them into smaller ones. A big problem is complex to code and test.
	- Lay out the general steps of an algorithm without going into details
	- Try to solve a problem in 1-2 sentences!!!
	- If you can't, raise your abstraction
    	- create helper methods/functions
      	- push detailed steps to methods/functions 

- Verify our algorithm with the test examples before coding.


## Interview Tips
- We should learn to **verbalise our thought process** throughout the interview to maintain engagement. This gives interviewer(s) insights into our approach to problem solving and the considerations we may have

- Always work towards a working solution first. **Working solution >> no solution**. Refactoring or optimisation can come later after we have something working.

- Every step in the PEDAC process is a form of **de-risking**. From improving our problem understanding, identifying edge cases and boundary conditions, selecting suitable data structures and working out the algorithm are all steps to **systematically constraint the solution space**, steering us in the direction towards a robust solution. Every step builds on the preparation/choices made in the earlier step.

- Always check our building blocks to avoid cascading errors
	- run code often
	- debug locally at line or helper method level

- Manage our energy. The earlier PEDAC steps are more complicated and requires the most energy. Spend sufficient time and do well there and algorithm and coding becomes much easier.
