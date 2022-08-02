# VIM - Getting Started
## Section Links
[Enter VIM](#entering-vim)\
[Exit VIM](#exit-vim)\
[Modes](#modes)\
[Moving Cursor In Vicinity](#moving-cursor-in-vicinity)\
[Moving to Specific File Location](#moving-to-specific-file-location)\
[New Line](#new-line)\
[Insertion and Appending](#insertion-and-appending)\
[Deletion](#deletion)\
[Change](#change)\
[Undo](#undo)\
[Copy and Paste](#copy-and-paste)\
[Replace](#replace)\
[Search](#search)\
[Find and Replace](#find-and-replace)\
[Execute External Command](#execute-external-command)\
[Set Options](#set-options)\
[Splitting Screens](#splitting-screens)\
[Highlight Syntax](#highlight-syntax)\
[Help](#help)\
[References](#references)

---

## Enter VIM
- Type `vim` in terminal to open a new, unnamed file.  
- Alternatively, type `vim Filename` in terminal to open an existing file or create a file with that name.

## Exit VIM
- `:q` to quit if there are **no unsaved change** in file
- If there are **unsaved changes**:
	- `:wq Filename` to save and quit for unnamed file. If current file has a different filename, this will save the content into a new file with this given name. 
	- `:wq` to save to current file and quit
	- `:q!` to **discard all changes** and quit

## Modes
There are 3 commonly used modes in Vim. They are:
- `Normal`: You use this mode to **issue commands and navigate the file**. Issued commands will appear in either the bottom left or right corner. Press `<ESC>` to enter this mode. 
- `Insert`: You use this mode to **compose or edit text**. Press `i` to enter this mode.
- `Visual`: You use this mode to **highlight or select text**. Press `v` to enter this mode. 

**Note**: Pressing `<ESC>` will place you in Normal mode or clear any unwanted or partially completed command.

[Back to Top](#section-links)


## Navigation
### Moving Cursor In Vicinity
- Directional keys:
	- `h`: left,     `j`: down,      `k`: up,     `l`: right 
- `e` to move cursor to **end of current word**.
- `^` and `$` to move cursor to **start and end of line** respectively. This symbol is same as that used in regular expressions.
- **Count + motion** format for repeated motions. Count can be any number while motions can be  `w` for start of next word, `e` for end of current word, `$` for end of line. Examples include:
	- `2w` to move cursor two words forward
	- `3e` to move cursor to end of third word in forward direction
	- `0` to move to start of line

### Moving to Specific File Location 
- `CTRL` + `G` to **display cursor location in file**
- `G` to move to **end of file**
- `gg` to move to **start of file**
- `number G` to move to that **particular line number**.

[Back to Top](#section-links)


## Text Editing
### New Line
- `o` to open a line **below** the cursor and enter insert mode
- `O` to open a line **above** the cursor

### Insertion and Appending
- `i` to to insert text **before** cursor
- `a` to insert text **after** cursor
- `A` to append text **after end of line**.

[Back to Top](#section-links)


### Deletion
- `x` to **delete single character** where cursor is positioned
- **Operator + motion** format. `d` is the delete operator
	- `dw` to delete from cursor to start of **next word**, **excluding** first character
	- `de` to delete from cursor to end of **current word**, **including** last character
	- `d$` to delete from cursor to end of **current line**, **including** last character
- **Operator + count + motion** format will repeat the operator motion by count times. For example:
	- `d2w` will delete to words up to but **excluding** starting character of third word.
	- Note: **count + operator + motion** also works
- `dd` to delete an **entire line**. `ndd` to delete **n lines**.

### Change
- `c` change operator is similar to `d` excepts it **automatically transit to Insert mode after deletion**.
- `ce` will **delete an erroneous word** (from cursor to end of word) and enter **insert** mode for you to make the changes. It is equivalent to `de` + `i`
- `c$` will delete from cursor to **end of line** and enter insert mode for you to make changes. It is equivalent to `d$` + `i`
- `cc` will **delete an entire line** and enter **insert** mode for you to make the changes. It is equivalent to `dd` + `i`
- It also supports the format `c [count] motion`, where motion could be `w` for start of next word, `e` for end of current word, `$` for end of line, `c` for entire line. 

[Back to Top](#section-links)


### Undo
- `u` to undo previous command
- `U` to undo all changes to a line and return it to original state
- `CTRL-R` to undo the undo's. Equivalent to redo in word document.

### Copy and Paste
- `y` operator yanks (copies) text. Equivalent to `ctrl+x` in word document.
- `p` puts (pastes) text, including text deleted but held in buffer via `x`, `dd`, `d$`. Equivalent to `ctrl+v` in word document.  

### Replace 
- `r` to replace a **single character** at cursor position
- `R` to replace **multiple characters** until `<ESC>` pressed.

[Back to Top](#section-links)


## Search
- `/phrase` search **forward** for a phrase. Match is case sensitive.
- `?phrase` search **backward** for a phrase
- `n` after search will search for the next occurrence of phrase in **same** direction.
- `N` after search will search for the next occurrence of phrase in **reverse** direction.
- `CTRL`+ `O` to go to older positions
- `CTL`+`I` to go to newer positions
- `%` while cursor is on `(,), [,], {,}` will go to its match
- See [Set Options](#set-options) for options related to search e.g. case insensitive match

## Find and Replace
`:s/old/new` will substitute new for the first old on a line
`:s/old/new/g` will substitute new for all olds on a line
`:%s/old/new/g` will substitute all occurrences in the file 
`:%s/old/new/gc` will ask for confirmation before substituting each occurrence in the file
`:num1,num2s/old/new/g` will substitute new for olds between lines num1 and num2

[Back to Top](#section-links)


## Execute External Command
-`:!command` will execute an external comand. Examples include:
	- `:!ls` will show directory listing
	- `:!rm Filename` will remove file Filename
- `:w Filename` writes the current Vim filw to disk with name Filename
- `v motion` + `:w Filename` will save visually selected text into file Filename
- `:r Filename` retrieves Filename and puts it below cursor position
- `:r !command` reads output of `command` and puts it below cursor position

[Back to Top](#section-links)


## Set Options
- `:set xxx` sets the option "xxx". Possible **search options** include:
	- `ic` or `ignorecase`: ignore upper/lower case when searching
	- `is` or `incsearch`: show partial matches for a search phrase
	- `hls` or `hlsearch`: highlight all matching phrases
- Prepend `no` to switch an option of e.g. `:set noic`
- Possible line number options include:
	- `number` to show line numbers
	- `relativenumber` to show relative line numbers

[Back to Top](#section-links)


## Splitting Screens
- `CTRL+VS` or `:sc` to split  screen horizontally based on cursor position
- `CTRL+WV` or `:vsplit` to split screen vertically
- `CTRL-W + Arrow Key` to move screen in direction of arrow
- `CTRL-W` + `Tab` to move across screen in sequence
- `CTRL + wq` will close current window
- `:vertical terminal` or `:vert term` to split screen vertically and open a terminal. `exit` to close the terminal when done.

[Back to Top](#section-links)


## Highlight Syntax
- `:syntax on` to turn on syntax highlighting for the **current** vim session. `syntax off` to turn off syntax highlighting.
- To **permanently** turn on syntax highlighting, create or edit the `.vimrc` file and add the `syntax on` command text. 
	```terminal
	sudo vim ~/.vimrc
	```
		
	```terminal
	# .vimrc
	syntax on
	```

[Back to Top](#section-links)


## Help
- `:help` to open help window
- `:help cmd` to find help on cmd
- `:q` to quit help window
- `: [CTRL+D | Tab]` to list all possible completions or just one completion respectively.

[Back to Top](#section-links)


## References
- [Launch School - Intro to VIM](https://www.youtube.com/watch?v=MEoqKgbz7NU)
- Vimtutor, accessible on MacOS and Linux OS by typing `vimtutor` in terminal.
- [Linux Hint - Syntax Highlighting](https://linuxhint.com/vim_syntax_highlighting/)
- [Youtube - Screen Splitting](https://www.youtube.com/watch?v=sHGiC6Fp800)
- [Stack Overflow - Open Terminal in Split Screen](https://stackoverflow.com/questions/38329792/is-it-possible-to-split-a-window-in-vim-vi-with-a-terminal)

[Back to Top](#section-links)