Very good list I found of VIM shortcuts. These are vanilla VIM shortcuts and will work on almost all versions of VIM without any extra plugins/configuration. From here: https://www.reddit.com/r/vim/comments/v1xrwv/my_list_of_most_used_vim_shortcuts/

## Basic:

* `:w` - save
* `:wq` - save & quit
* `:q!` - discard changes and exit
* `u` - undo
* `Ctrl + r` - redo
* `i` - insert before cursor
* `a` - insert after cursor

## Movement:

* `hjkl` - left, down, up & right respectively
* `w` - jump to next word
* `b` - jump to previous word
* `e` - jump to last character of the word
* `^` - jump to first non-whitespace character in the line
* `0` - jump to start of line
* `$` - jump to end of line
* `I` - insert at the start of line
* `A` - append to the end of line
* `gg` - jump to the top of file
* `G` - jump to end of file
* `:{line_number}` or `{line_number}gg` - go to a specific line
* `%` - jump to matching brackets `({[]})`
* `Ctrl + d` - scroll down
* `Ctrl + u` - scroll up

## Search:

* `f{character}` - jump to next occurrence of the `{character}` in the line
* `F{character}` - jump to previous occurrence of the `{character}` in the line
* `/{pattern}` - forward search for `{pattern}` (`n` to jump to the next match and `N` to jump to previous match)
* `?{pattern}` - backward search for `{pattern}` (`n` to jump to the next match and `N` to jump to previous match)
* `:%s/old_str/new_str/gc` - find and replace every occurrence of `"old_str"` with `"new_str"` (with a yes/no prompt for each occurrence)
* `:%s/old_str/new_str/g` - find and replace every occurrence of `"old_str"` with `"new_str"`

Note: You can use a colon instead of a forward slash as well. This is useful if there is a forward slash in the string to be searched or replaced.

## Delete:

* `dd` - delete the current line including newline character
* `cc` - delete the current line and start insert mode
* `{count}dd` - delete `{count}` number of lines. eg: `3dd` deletes 3 lines
* `{count}cc` - delete `{count}` number of lines and start insert mode
* `x` - delete character under cursor in normal mode
* `s` - delete character under cursor and start insert mode
* `X` - delete character to the left of the cursor and stay in normal mode
* `r{new_char}` - replace character under cursor with `{new_char}` in normal mode
* `Ctrl+w` - delete the last word you typed in insert mode
* `ggdG` - delete complete document

Prefix `"d"` to stay in normal mode and `"c"` to enter insert mode for the following shortcuts:

* `d/c{count}{motion}` - Eg: `d2e` deletes two words
* `d/c$` - delete from current position to end of line
* `d/ciw` - delete word
* `d/ciW` - delete word including hypens
* `d/ce` - delete to end of word
* `d/caw` - delete word including whitespace
* `d/cw` - delete to end of word including whitespace
* `d/cW` - delete to end of word including hypens
* `d/ci"` - delete inside double quotes
* `d/cit` - delete inside html tag
* `d/cat` - delete outer html tag
* `d/cib` - delete a block surrounded by `(`
* `d/ciB` - delete a block surrrouned by `{`
* `d/cas` - delete a sentence
* `d/cap` - delete a paragraph

## Cut, Copy and Paste:

* `y` - yank selection
* `yw` - yank to end of word including whitespace
* `ye` - yank to end of word
* `y$` - yank to end of line
* `yiw` - yank inside word
* `yit` - yank inside html tag
* `yy` - yank the current line including the newline character.
* `^y$` - yank the current line without the newline character
* `^d$` - Cut the current line without the newline character
* `{number}yy` - yank `{number}` of lines. eg: `2yy` yanks two lines
* `:%y` - yank entire file
* `p` - paste after cursor
* `P` - paste before cursor
* `yyp` - duplicate line and paste below
* `yyP` - duplicate line and paste above

## Copy/Paste to and from an external program:

* `Ctrl + shift + v` - paste to vim from an external program
* `"+y` (Must be in normal mode) - yank from vim to an external
program. To remap this shortcut to Ctrl-c, add `vnoremap <C-c> "+y` to vimrc.

## Select:

* `V{line_no}G` - select lines upto `{line_no}`. eg: `V35G` selects up to line 35
* `vat` - select outer html tag
* `vit` - select inside html tag

## Wrap text:

First set the textwidth in vimrc using `set textwidth=80`. Then do:
* `gqq` - wrap single line
* `gggqG` - wrap whole document

## Switch between tabs:

* `gt` - next tab
* `gT` - prev tab
