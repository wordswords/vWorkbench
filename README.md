# My Development Enviroment (dotfiles)

"Every woodworker needs a good, solid, reliable workbench, somewhere to
hold work pieces at a convenient height while they're being shaped.
The workbench becomes the centre of the woodshop, the maker returning
to it time and time again as the piece takes shape.

For a programmer manipulating files of text, that workbench
is the command shell."

- The Pragmatic Programmer (2020) - David Thomas, Andrew Hunt

![Alt text](workbench.jpg "Picture of a woodworker workbench")

<!--ts-->
* [My Development Enviroment (dotfiles)](#my-development-enviroment-dotfiles)
   * [What Is This](#what-is-this)
   * [Demo Video](#demo-video)
   * [VIM](#vim)
      * [How to Decode the vim-airline Buffer Status line](#how-to-decode-the-vim-airline-buffer-status-line)
      * [How to Decode the Nerdtree file status symbols](#how-to-decode-the-nerdtree-file-status-symbols)
   * [ZSH](#zsh)
* [Installation / Updating](#installation--updating)
   * [Installation Requirements for .dotfiles](#installation-requirements-for-dotfiles)
   * [What It Will Install](#what-it-will-install)
   * [Install Steps](#install-steps)
* [Using the Dotfiles Environment](#using-the-dotfiles-environment)
   * [Shell shortcuts](#shell-shortcuts)
   * [VIM9 shortcuts](#vim9-shortcuts)
   * [YouCompleteMe](#youcompleteme)
   * [The Clipboard](#the-clipboard)
   * [Productivity Shortcuts](#productivity-shortcuts)
      * [Tmux shortcuts:](#tmux-shortcuts)
      * [Tmux pane resize shortcuts:](#tmux-pane-resize-shortcuts)
      * [Gnome shortcuts:](#gnome-shortcuts)
      * [Gnome window resize shortcuts:](#gnome-window-resize-shortcuts)
   * [VIM Spellchecking/Grammar checking/Proofreading commands (also Joplin notes)](#vim-spellcheckinggrammar-checkingproofreading-commands-also-joplin-notes)
   * [VIM9 Leader Search Functions](#vim9-leader-search-functions)
   * [Git Fugitive Workflow](#git-fugitive-workflow)
   * [Git Fugitive Blame Window](#git-fugitive-blame-window)
   * [Git Fugitive Mergetool](#git-fugitive-mergetool)
   * [VIM's inbuilt terminal](#vims-inbuilt-terminal)
   * [VIM modelines and folds](#vim-modelines-and-folds)
   * [VIM Regex](#vim-regex)
   * [Wildcards for searching and editing files and directories](#wildcards-for-searching-and-editing-files-and-directories)
   * [Processing lots of files with :argdo](#processing-lots-of-files-with-argdo)
   * [GitHub Copilot](#github-copilot)
   * [Vista Plugin](#vista-plugin)
* [Additional Notes](#additional-notes)
   * [Tmux](#tmux)
   * [Git information I keep forgetting](#git-information-i-keep-forgetting)
   * [GNU diff/patching information I forget](#gnu-diffpatching-information-i-forget)
      * [Creating a simple patch to apply later](#creating-a-simple-patch-to-apply-later)
      * [Applying the simple patch](#applying-the-simple-patch)
   * [Python 3 information I forget](#python-3-information-i-forget)
   * [Using Strace](#using-strace)
   * [Regular Expressions](#regular-expressions)
   * [Docker/Docker Compose information I forget](#dockerdocker-compose-information-i-forget)
   * [Troubleshooting Disk I/O performance Notes](#troubleshooting-disk-io-performance-notes)
      * [Iostat](#iostat)
      * [Fio](#fio)
      * [DD](#dd)
      * [Bonnie++](#bonnie)
   * [Troubleshooting CPU utilisation Notes](#troubleshooting-cpu-utilisation-notes)
   * [Troubleshooting Network utilisation Notes](#troubleshooting-network-utilisation-notes)
   * [Ubuntu Package information](#ubuntu-package-information)
   * [Profiling VIM to find plugin speed problems](#profiling-vim-to-find-plugin-speed-problems)
   * [Joplin commandline](#joplin-commandline)
   * [JIRA Go Client](#jira-go-client)
   * [Printing (on Ubuntu)](#printing-on-ubuntu)
   * [fzf](#fzf)
   * [Remote Connection](#remote-connection)
   * [24 bit colour](#24-bit-colour)
   * [External Scripts](#external-scripts)
      * [search-ebooks.sh &lt;search terms&gt;](#search-ebookssh-search-terms)
      * [clean-git-checkout.sh &lt;path&gt;](#clean-git-checkoutsh-path)
      * [install-node.sh &lt;major version&gt;](#install-nodesh-major-version)
      * [make-and-install-vim.sh &lt;version&gt;](#make-and-install-vimsh-version)
      * [update-joplin-cli.sh](#update-joplin-clish)
      * [fix-whitespace-problems.sh &lt;path&gt;](#fix-whitespace-problemssh-path)
      * [mlnx_tune](#mlnx_tune)
      * [get-weather.sh](#get-weathersh)
      * [secure-home-dir-perms.sh](#secure-home-dir-permssh)
      * [hq-read-epub.sh &lt;search terms&gt;](#hq-read-epubsh-search-terms)
      * [delete-all-docker-content.sh](#delete-all-docker-contentsh)
      * [ai-files-purpose.zsh](#ai-files-purposezsh)
      * [ai-dir-purpose.zsh](#ai-dir-purposezsh)
      * [osx.zsh](#osxzsh)
      * [repos.sh](#repossh)
      * [blameline](#blameline)
      * [git logline](#git-logline)
* [Modifying](#modifying)
<!--te-->

## What Is This

* My development environment setup with heavily custom settings.
* I'm testing this on Ubuntu 23.01 and on my W11 box running Ubuntu under
  WSL2.
* I also test it under the latest Lubuntu LTS. I haven't tested it on OSX
  for ages, and can pretty much guarantee it won't run on that without
  a lot of work.

## Demo Video

[![Watch the video](https://img.youtube.com/vi/X91F5WvubPs/0.jpg)](https://www.youtube.com/watch?v=X91F5WvubPs)

## VIM

![Alt text](https://i.imgur.com/K6fBzSH.png "VIM setup")

### How to Decode the vim-airline Buffer Status line

Full docs: [https://github.com/vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)

1. The problems in the file show in the far right. If there are no issues
there will be no red or orange expanded sections.

* Orange - Warnings
* Red - Errors

2. It will show you the number of warnings or errors there are, and the line number of
the first one. You should be able to skip between warnings/errors with the
`<Left>` and `<Right>` keys.
3. When you are searching through the file with `/` then it shows you: your term,
the number of matches there are of your term, and which one you're on.
4. Other info displayed includes File Format, file type detected, current line of
code / total lines of code, current column number / total columns, and so on.
5. When it shows 'SPELL' is on, it will highlight text spellings and any
code related errors. To toggle this, use `:set nospell` or `:set spell`. It
highlights spelling errors in comments.

### How to Decode the Nerdtree file status symbols

They correspond to the git status of the file in the repo.

* 'Modified'  :`✹`
* 'Staged'    :`✚`
* 'Untracked' :`✭`
* 'Renamed'   :`➜`
* 'Unmerged'  :`═`
* 'Deleted'   :`✖`
* 'Dirty'     :`✗`
* 'Ignored'   :`☒`
* 'Clean'     :`✔︎`
* 'Unknown'   :`?`

## ZSH

![Alt text](https://i.imgur.com/oZmTLND.png "My zsh setup")

ZSH uses oh-my-zsh in Powerlevel10k mode, which provides fast and responsive
auto-complete options. Use `<TAB>` to autocomplete. It will also show the status
of the current Git repo.

https://github.com/romkatv/powerlevel10k

# Installation / Updating

The same scripts either install from nothing OR update the current
version. When you install my .dotfiles every time you log into a console, it
will fetch down the latest master from this repo. If there are any changes, you
should rerun the scripts in 'Install Steps' below to keep your copy
up-to-date.

## Installation Requirements for .dotfiles

* You have to use a ‘Nerd font’ - this is a specially patched font with extra
symbol characters for use in vim. This is not a prerequisite, it will show you
how to install it at the end of the dotfile deployment.
* You have to have a directory created in ~/.dotfiles/SECRETS with the credentials
/keys/APIkeys required to use the environment. This is not done for you.
* If you are using Ubuntu for Windows under WSL2, which is my personal favourite configuration
then I recommend installing the Alacritty terminal emulator before installing.

## What It Will Install

It will install my VIM9 development environment and anything else I use
in my work. It includes:

* Install my heavily customised version of VIM9 with plugins
* Install the latest version of Oh-my-ZSH and set your default shell to ZSH
* Install Joplin the command-line open source Evernote replacement, and secure
it with encryption, and download all my notes (presuming you are me).
* Ask if you want to install my usual apps - https://Morgen.so : a paid multiplatform
calendar app that I use with Google Calendar. This is updated
via the snap installation process.
* Ask if you want to install the superb Golang JIRA CLI client which makes
navigating JIRA boards less painful.
* Setup a development environment for Elixir.
* Setup 'fortune' with random Neil Gaiman quotes displayed on login.

You may well have to customise, mix and match, and edit these individual
settings because you won't have the authentication required for this whole
process to work. If you are serious about reusing what I've done, you should
run this setup in a docker container or virtual machine.

## Install Steps

I am still in the process of separating my personal configuration from a generic
configuration which will be useful to everyone.

However, if you are keen to try this out as it is:

1. `git clone git@github.com:/wordswords/dotfiles ~/.dotfiles`
2. `cd ~/.dotfiles/`
3. Prepare all config you need to prepare in ~/.dotfiles/SECRETS. There are
templates of what is required in ~/.dotfiles/SECRETS_TEMPLATES
4. `./deploy.sh`
5. It will also attempt by default to log in to my Joplin account, which will
not succeed without my credentials. You probably want to change that.

# Using the Dotfiles Environment

## Shell shortcuts

1. `<CTRL>-<R>` for an intelligent search through previous commands using McFly.
2. Type `z` and a directory name accessible from your current directory to cd to
that directory, no need to type cd.
3. Type `l` for a long-style ls.
4. `delta <file1> <file2>` for a nice 2 way diff style interface where you can
analyse and copy changes between files.
5. Use `<tab>` to activate oh-my-zsh's autocomplete plugins. For example `git
<tab>`
6. Run `repos.sh` to check the branch name of all git repositories under the
current directory. Useful when you have a lot of different projects
that interact with each other and you want to see which repos branches
you have checked out.
7. `vi` instead of `vim` to load a separate minimal vim config, useful if
there are problems with the vim config.
8. Type `notes` to launch Joplin, my note-taking app.
9. `please` after realising that you needed sudo with the last command, to
    repeat the last command with sudo
10. `ports` to list the open ports on the system in a readable way.
11. `tree` for a handy diagram of the full directory tree under the current
directory.
12. ref <jira issue number, no prefix>` to open Firefox with the details
of that issue.
13. `lookup <jira issue number, no prefix>` to print the jira-cli ticket
summary of that issue on the command line.
14. `bat <file>` for a syntax-highlighting quick cat.
15. `hn` to get the top 10 Hacker News Network headlines for the hour.
16. `hn100` to get the top 100 Hacker News Network headlines for the hour.
17. `gg <search query>` from the terminal to open a Firefox browser with the
query in the Google.co.uk search engine.
18. `so <search query>` from the terminal to open a Firefox browser,
and search stackoverflow using `<search query>`
19. `pstree` for a nice graph showing all processes and subprocesses running.
20. `<CTRL-X> <CTRL-E>` to open up a text editor while in a shell. When you
save the text content, it will copy it back to the shell to execute. You can use
this method to use GitHub Copilot and OpenAI Codex in VIM to generate shell commands
and then have them execute in the shell.
21. `cht <language> <command>` to consult the chtsht.sh repository of high quality
cheatsheets on a lot of subjects.
22. `ai <query>` to ask ChatGPT for some wisdom. Whatever it returns will
be copied to the clipboard.

## VIM9 shortcuts

The most important VIM shortcut is `<leader> h` which is currently mapped to `, h`.
This will open up this document, which is usually up-to-date.

1. `<TAB>` to activate autocomplete plug ins.
2. `,` is set to be the `<leader>` key in VIM9, use it to trigger shortcuts.
3. `<LEFT>` to toggle the file browser/NERDTree buffer.
4. `<RIGHT>` to toggle Vista, which allows you to quickly jump through files.
5. `<DOWN>` to open the Quickfix list of errors.
6. `<UP>` to open the Location list of errors.
7. `>>` and `<<` to adjust indentation.
8. `set mouse=a` is on, if you have any problems with copying and pasting just
`:set mouse=` beforehand.
9. `K` to bring up documentation on the current term and use the mouse wheel to
scroll the info.
10. `gd` to go to the definition of function or class.
11. `:G <git command>` to run a git command via vim-fugative, for example
`git diff`, `git add`.
12. Use `/` and start typing to quickly jump to a certain term across all open
buffers.
13. Use `u` to go up a root directory on nerdtree.
14. Use `<F12>` to toggle distraction-free writing mode.
15. Use `:Format` to format a buffer by the coc language server's prettifier,
where it exists.
16. Type `:Wordy<space><tab>` to use the Wordy proofreading tool to check for
poor words while writing.
17. Type `:LanguageToolCheck` to use the command-line grammar and spelling
checker (requires Java 8).
18. To search all instances of `git clone` and replace them with `git submodule
add` on a visual block, use `:<','>s/git clone/git submodule add/`.
19. To feed a visual block through an external command, for example, the NIX
external sort command, `:'<,'>!sort` - this will sort the visual block lines
alphabetically.
20. To execute a command on all lines in a visual block, use the norm
command, for example: `:'<,'> norm i##` after selecting in visual mode to comment
all lines out with a `##`. For the reverse, to uncomment and delete the first
character, use `:'<,'> norm x` after selecting in visual mode.
21. To generate a ctags index for all functions/methods in all languages, run
this command at the root of the source control repo ``!ctags -R *``. Then you can
use `gd` to jump to the original definition of the function in any file.
22. If in some modes the backtick character does not insert, try typing it twice
that should insert it properly.
23. To open the URL under the cursor in the default browser use `gx` <- handy!
24. To remove all trailing white space from a file, use `:%s/\s\+$//e` <- handy!
25. To run Prettier on language servers that support this VS Code prettier,
use `:Prettier`
26. ``:%norm vipJ`` to unwrap all the text in the document (opposite to
word-wrap)
27. `%` when positioned over a code bracket to skip to the next code bracket
28. `>i{` when positioned over a code bracket to ident the code up to the next
code bracket
29. `:map` to show the keymappings made by your plugins and .vimrc. Note this is
somewhat difficult to follow.
30. ``*`` and ``#`` will search forward and backward through the file with the exact
same word that is under the cursor in normal mode.

[https://github.com/wordswords/dotfiles/blob/master/notes/VIMCHEATSHEET.md](https://github.com/wordswords/dotfiles/blob/master/notes/VIMCHEATSHEET.md)

## YouCompleteMe

I have moved away from Coc.vim to use YouCompleteMe. It has completion options for
all the major languages and supports language servers.

The main difference is that the errors are now in the locationlist.

So it's the quickfix list for spelling/grammatical errors, and the locationlist
for coding errors.

I might combine the two sometime in the future.

## The Clipboard

Under Ubuntu, there are two clipboards, for some crazy reason that I don't
understand.

As part of the installation of the this environment, Gnome is patched via
a hook, to synchronise these clipboards.

Under Ubuntu4Windows, the clipboard should also be synced to the Windows clipboard.

These shortcuts should therefore work for all clipboard contents, across Gnome, your
web browser, Tmux, VIM9, VIM9 terminal and gVIM.

1. `<Control-c>` copies text in Gnome applications including the web browser, after
being selected by the mouse. Also 'copy' using the right click will copy.
2. `<Control-v>` should paste in all Gnome applications, except for the
terminal, including the web browser. Also you can use right click -> 'paste'.
3. While in the Gnome terminal, or in the Gnome terminal in tmux,
`<Control-Shift-v>` will paste to the terminal.
4. While in tmux, `<Control-a-{>` will enter clipboard mode which is similar to VIM's
visual mode. Scroll using VIM keybindings, page up, page down, or the mouse, and
press `v` to start the selection copy, and `y` to copy it onto the clipboard.
5. While in VIM, `<Control-v>` will switch into insert mode, switch into paste mode,
paste the text, and then switch out of paste mode.
6. While in VIM, using `y` will yank straight to the clipboard. Usually I use visual
mode to copy things while in VIM.
7. While in any terminal, you can use the `pbcopy` or `pbpaste` aliases in a pipe.
For example `echo This will be copied to the clipboard | pbcopy` and `pbpaste | sort`
8. If you want to, you can also do `echo This will be copied to the clipboard | xclip.sh`

## Productivity Shortcuts

The more you can use the keyboard and not a pointing device, the faster you will be,
and the less ergonomic problems you will have.

### Tmux shortcuts:

1. `<Control-a> <RIGHT>` move to the right pane from the cursor.
2. `<Control-a> <DOWN>` move to the down pane from the cursor.
3. `<Control-a> <UP>` move to the up pane from the cursor.
4. `<Control-a> <LEFT>` move to the left pane from the cursor.
5. `<Control-a> r` reload current config file.

### Tmux pane resize shortcuts:

1. `<Control-a> <Control-RIGHT>` Extend current pane to the right
2. `<Control-a> <Control-DOWN>` Extend current pane down
3. `<Control-a> <Control-UP>` Extend current pane up
4. `<Control-a> <Control-LEFT>` Extend current pane to the left
5. `<Control-a> <SPACE>` Switch through different pane arrangements. Also useful for clearing
any problems with a garbled terminal.

### Gnome shortcuts:

1. `<Control-Shift-n>` open a new terminal window from anywhere on the gnome desktop.
2. `<Windows Key>` toggle ArcMenu. Start typing to search for an application to run.
3. `<Windows Key-Tab>` switch to next application (better than alt-tab)
4. `<Windows Key-Shift-Tab>` switch to previous application (better than alt-shift-tab)
5. `<Windows Key-l>` lock the Gnome session so it requires a pwd to get back in
6. `<Print Screen>` take a screenshot using Gnome internal screen shot tool. Very useful.
7. `<Control-Alt-Home>` OR `<Control-WEB>` (on Kinesis keyboard) - open a new tab in Firefox
and move the focus to it. This is a custom shortcut that I implemented from here:
[https://askubuntu.com/questions/831135/shortcut-to-open-new-browser](https://askubuntu.com/questions/831135/shortcut-to-open-new-browser)
8. Select a valid URL in Gnome terminal and then `<Control>-Left Click` to open it in a web
browser
9. `<Windows Key-d>` minimise all applications and show a blank desktop.

### Gnome window resize shortcuts:

It behaves like Windows 10/11 window resize shortcuts. For example:

1. `<Windows Key-RIGHT>` take the current window and move it to 50% right of screen
2. `<Windows Key-LEFT>` take the current window and move it to 50% left of screen
3. `<Windows Key-UP>` take the current window and full screen it
4. `<Windows Key-DOWN>` take the current window and un-full screen it, move it into a
window in the centre of the desktop

## VIM Spellchecking/Grammar checking/Proofreading commands (also Joplin notes)

1. `<LEFT>`       - toggle Nerdtree
2. `<RIGHT>`      - toggle Vista
3. `<DOWN>`       - to open the Quickfix list of errors.
4. `<UP>`         - to open the Location list of errors.
5. `zg`           - Mark as a good word
6. `zw`           - Like `zg` but mark the word as a wrong (bad) word
7. `zug`          - Unmark as good word
8. `zuw`          - Unmark as wrong (bad) word
9. `z=`           - For the word under/after the cursor suggest correctly spelled
words
10. `1z=`         - Use the first suggestion, without prompting
11. `.`           - Redo - repeat last word replacement
12. `:spellr`     - Repeat the replacement done by `z=` for all matches
    with the replaced word in the current window
13. `<F12>`       - Toggle 'Goyo' distraction-free mode.

[![asciicast](https://asciinema.org/a/518234.svg)](https://asciinema.org/a/518234)

## VIM9 Leader Search Functions

`<leader>` is currently set to 'commma' e.g. `,`

First move the cursor over a word or line and then:

1. `<leader> h` to access this help file and to toggle opening and closing
this file and the outline
2. `<leader> w` to look up the current single word on Wikipedia
3. `<leader> b` to look up the current line with git blame
4. `<leader> j` to look up the current issue number under cursor with jira-cli
5. `<leader> p` to save the current file as a markdown-formatted code post
for Reddit in the location `~/redditpost.md`
6. `<leader> y` to copy the whole current file to the clipboard
7. `<leader> l` to run the LanguageToolCheck command on the current file to check current
grammar and spelling.
8. `<leader> c` to toggle Copilot enable/disable on the current file

In visual mode you can also do:

1. `<leader> g` to open a Firefox window with the google results of the lines in the visual
selection
2. `<leader> s` to open a Firefox window with the Stackoverflow results of the lines in the
visual selection

## Git Fugitive Workflow

1. `:Git` to bring up the interactive git status message while on a changed track file.
2. `a` to stage or `d` to unstage a file
3. `:Git commit` will commit the staged files
4. `:Git push` will push the commit
5. `:Git diff` will open a diff
6. `g?` displays help with more commands.
7. `:q` to close the status window, you never need to write changes.

## Git Fugitive Blame Window

1. `:Git blame` for line-by-line git blame on current file, select a commit
and press 'o' to open the commit diff with the commit message in a new window.
2. `Enter` to open a diff of the chosen commit in current window
3. `C` `A` and `D` resize the blame window up until the commit, author and date
respectively.
4. `g?` displays help with more commands.

## Git Fugitive Mergetool

1. Whenever you have a merge conflict, use `git mergetool` to open this.
2. If you want to just use one entire side, move your cursor to that side with `<Ctrl-W> h`, for example. Then do `:Gwrite!`.
3. Buffers are set up so `[YOUR local branch (2) | resulting mergefile (1) | THEIR merge in branch (3) ]`
4. Use `]c` and `[c` to navigate through the conflicts
5. Use the centre pane to navigate. use `d2o` to pull the change from YOUR local branch, use `d3o` to pull the change from THEIR branch.
6. OR go to local branch OR merge in branch, select the conflict, and use `dp` to choose that version.
7. When done, use `:wq`

More info:
[https://www.youtube.com/watch?v=iPk4nOLj8w4](https://www.youtube.com/watch?v=iPk4nOLj8w4)

## VIM's inbuilt terminal

1. You can run arbitrary commands such as ``:term ls -al`` and see the results in
an updating terminal.
2. It is recommended that if you want an interactive terminal, use a tmux split.
This is because the paste functionality doesn't work too great while in VIM9 terminal.
Also, it has problems running some terminal applications while run under VIM9 in tmux.

## VIM modelines and folds

Several of my dot files, including the main deploy scripts, use modelines to set up
some fold markers. This allows for much easier organisation and navigation.

Modelines are enabled by default with the security patch.

1. To expand a fold, press 'l' when on the fold.
2. The mouse can also be used to open and close folds by clicking in the
fold column: Click on a '+' to open the closed fold at this row. Click on any other
non-blank character to close the open fold at this row.
3. To close a fold `zc` when the cursor is on it
4. To close ALL folds `zm`
5. To open ALL folds `zn`

## VIM Regex

1. Turn on "Very magic mode" for VIM when you have to enter a regex that
includes a lot of special characters. `:s/\(cat \) hunting \(mice\)/\2 hunting
\1` then becomes `:s/\v(cat) hunting (mice)/\2 hunting \1`. Trigger 'very magic
mode' by prefixing the regex with `\v`.
2. Find a full table of VIM regex syntax with `:help ordinary-atom`
3. Use group marks `\1` `\2` etc to identify characters captured by a capture
group, e.g. surrounded by `(` and `)`. For example, `:s/v(cat) hunting (mice)/\2
hunting \1` replaces 'cat' hunting 'mice' with 'mice' hunting 'cat.
4. Vim has a weird non-greedy regex match `.\{-}` which means `.+?`. So to
strip a document of all its html tags use this: `:%s/<.\{-}>/\r/g`.

## Wildcards for searching and editing files and directories

1. You can search across a bunch of files with the following syntax:
``:vimgrep /cat/ **/*.py`` will search for all instances of 'cat' in all the
python files down from the current path.
2. You can open a file without knowing the directory it is in, as long as it is
below the current directory, by ``:e **/bla.py``. This will search for a file
``bla.py`` recursively from the current directory.  If there is more than one file
found, it will error.
3. ``:help file-search`` for more wildcard options
4. If you want to edit a number of files called ``bla.py``, use ``:arg **/bla.py``.
This will open all the files one by one, use ``:next`` to edit the next file in
the list. Use ``:prev`` to reopen a file previously edited. ``:last`` and ``:first``
also work, and ``:args`` displays the whole list.

## Processing lots of files with ``:argdo``

You can process a number of files using arglist in VIM.

1. ``:arg`` defines the arglist
2. ``:argdo`` allows you to execute a command on all the files in the arglist
3. ``:args`` describes the list of files in the arglist

For example if we wanted to replace all instances of 'animal' in every Python
file recursively from the current path, we would do the following:

``:arg **/*.py``
``:argdo **/\<animal\>/creature/qa | update``
``**/*.py`` selects all python files down from the current directory recursively
``:argo`` executes a command on all files from current directory recursively.
``%s/\<animal\>/creature/qa`` replaces every occurrence of 'animal' with
'creature' in every file - ``a``, without raising errors if the matches are
not found - ``q`` ``update`` saves the file only if it has been modified

## GitHub Copilot

The GitHub copilot VIM plugin is installed. It assumes you have a subscription.

1. `<leader> c` to toggle copilot on and off for the current buffer. 
2. `<TAB>` to accept current autocomplete.

## Vista Plugin

Vista is used for language server specific function lists for quickly jumping
around large projects.

1. `:Vista` to load up the right sidebar
2. `:Vista vim_lsp` to use vim's LSP support to provide the tags list
3. `:Vista ctags`to use ctags to provide the tags list
4. `:help vista-commands` and `:help vista-options` for help

# Additional Notes

## Tmux

1. Config file is at `~/.tmux.conf`
2. For a great tutorial [https://pragmaticpineapple.com/gentle-guide-to-get-started-with-tmux/](https://pragmaticpineapple.com/gentle-guide-to-get-started-with-tmux/)
3. For a vertical split `<CTRL>-a SHIFT |`
4. For a horizontal split `<CTRL>-a SHIFT -`
5. For standard keybindings,`cht tmux`
6. To rotate panes in the current layout `<CTRL>-a <SPACE>`
7. To start my standard development tmux session `tmuxinator development`

## Git information I keep forgetting

1. `git status` - will tell you what branch you're on and what files have
changed. Use this all the time.
2. `git commit --amend` and `git rebase -i HEAD~2` - roll the current commit
into the previous one and edit the previous commit message. Use the rebase to
squash the commit.
3. `git branch` - show the current branches on your local copy
4. `git stash push` - push to the stash, puts all non-committed files on the
stash
5. `git stash pop` - pop whatever is on to stash to the local copy.
6. `git checkout -b <new branch name>` - create a new branch and switch to it
7. `git rebase -i HEAD~3` - perform an interactive rebase on the last _2_
commits.. e.g: you always want to +1 to the number. Be careful with this.
8. `git pull origin master` or `git pull origin main` - pull and merge
master/main into your current local branch
9. Use 'main' instead of 'master' for all future repos - everyone is doing it.
10. `git difftool` - use wherever you would use git diff - it's much more useful.
11. `git mergetool` - use whenever you have merges to make, see above.
12. `blameline` - shell script for line-by-line blame with commit summary.
13. When all goes horribly wrong, backup your changed files by manually
`mv`-ing them out of the repo directory, delete your entire local copy, checkout
again from master, and rebuild your commit by copying the backed up files in.
14. Use GitHub PR's 'changed files' tab for exactly what has changed, but don't
forget the commits tab, there should only usually be one commit per PR. And
remember the revert button on Github PRs.
15. `git logline` for my custom one line per commit log alias which includes
useful extra information, see: https://ma.ttias.be/pretty-git-log-in-one-line/
16. `git checkout -- <filepath>` - this will overwrite your local changes to
the file at <filepath> and restore the version in the latest commit on your
branch.
17. `git checkout <hash> <filepath>` - this will checkout a previous version of
the file from the <hash> commit. A useful technique for restoring a change from
a previous commit is to `cp <filepath> <filepath.bak>`, use `git logline` to
find the right hash and then, `git checkout <hash> <filepath>`, then use
`vimdiff <filepath> <filepath.bak>` to copy a change over from the previous
commit to `<filepath.bak>`, and then `rm <filepath>` and then
`mv <filepath.bak> <filepath>`.

Git Book:
[https://git-scm.com/book/en/v2](https://git-scm.com/book/en/v2)

Check out my simpleton Git workflow here:
[https://github.com/wordswords/dotfiles/blob/master/notes/GITWORKFLOW.md](https://github.com/wordswords/dotfiles/blob/master/notes/GITWORKFLOW.md)

## GNU diff/patching information I forget

### Creating a simple patch to apply later

1. To generate the patch, run the following command in the same directory
as the file you want to patch `diff -u <file1> <file2> > patch.diff`
2. Edit the patch file and make sure both filenames mentioned are the
same filename that you want patched.

### Applying the simple patch

1. Copy the patch.diff into the directory of the file needing to be patched
2. Run `patch -p1 < patch.diff`

## Python 3 information I forget

1. Use `ipython` for interactive REPL Python 3 information.
2. Add `import ipdb;ipdb.set_trace()` anywhere in your code to open up
an interactive debugger using ipython when the code hits that line.
3. Add `import IPython; IPython.embed()` to open up IPython when the execution
hits this point.

## Using Strace

You can use `strace` to find out what a Linux binary is exactly doing.
It will list all the system calls made by that binary.

For example:

`strace python follow.py`

Different flags you can use include: `-f` - follow child processes as they are
created by the original program, and there is a flag that will strace a particular
PID, so it will attach itself to an already running program.

## Regular Expressions

Lots of languages support regular expressions, but if you want to do complex things
on the command line with regex, then just reach for Perl. Even the latest modern sed
doesn't support all of the Regex spec that Perl does.

1. Find, exec and regex is a common thing I end up doing. This is how to do it in
Perl: ``find . -name '*.html' -exec perl -i -pe "s/jpg\?/jpg/g" {} \;``
2. Test 1 - BEFORE you do the above, always use an online regex checker such as:
(https://regexr.com/)[https://regexr.com/] which is very good for perl.
3. Test 2 - It is also worth echoing/catting data to the perl pipe with a regex so
that you can test things a second time before running a potentially dangerous regex query.
``echo 'bla.jpg?asdfasdf=asdfasdf' | perl -pe 's/(?<=[?&;]).*//g'``, just take the -i off the
line for a dry run, and to pick up input from the pipe instead of editing a file.
4. Remember to back up the files before running 1 too. `cp -r ./dir ./.bak.dir` can save hours.

## Docker/Docker Compose information I forget

1. `docker system prune -a` - remove all unused Docker container images.
This is essential to do occasionally to reclaim disk space.
2. `docker-compose --rm <service>` - execute <service> providing there is a
docker-compose.yml file in the current directory describing `<service>`.
3. `docker ps` - status information on all running docker containers.
4. `docker-compose ps` - status information on all running docker-compose
services.
5. `docker-compose run <service> <bash_command>` - run a quick bash command.
`<service>` must be a valid docker-compose service. For example `docker-compose
run wordpress cat /etc/issue`.
6. `docker logs <service>` - output the logs for a service. This is the
`<service>` name from `docker-compose ps`.
7. `docker build .` - builds the container described in the `Dockerfile` from
the local directory.
8. `docker-compose network ls` and `docker-compose network inspect <network id>` will get info
on the networks defined in docker compose.
9. For more examples on docker-compose networks and files, check out my server setup
here: [https://github.com/wordswords/dotfiles/blob/master/hqconfig/](https://github.com/wordswords/dotfiles/blob/master/hqconfig/)
10. `docker-compose up -d` will spin up the docker container(s) using docker-compose
and run it as a daeamon, e.g. in the background.
11. `docker-compose up` will spin up the docker container(s) using docker-compose
and run it in the foreground, and output all the logs to the terminal. Useful for
troubleshooting.
12. `docker-compose logs -f <container id>` will attach to the container ID and tail -f
the logs.
13. `docker-compose pull` will update all the containers in the docker-compose file with
the latest versions of the container tags.

Also, check out the notes I took from the Docker Deep Dive book here:
[https://github.com/wordswords/dotfiles/blob/master/notes/DOCKERNOTES.md](https://github.com/wordswords/dotfiles/blob/master/notes/DOCKERNOTES.md)

## Troubleshooting Disk I/O performance Notes

### Iostat

1. https://coderwall.com/p/utc42q/understanding-iostat
2. https://www.igvita.com/2009/06/23/measuring-optimizing-io-performance/

### Fio

1. https://tobert.github.io/post/2014-04-28-getting-started-with-fio.html
2. https://tobert.github.io/post/2014-04-17-fio-output-explained.html
3. http://serverfault.com/questions/677340/poor-iscsi-performance-with-ssd-disks-and-10-gbe-network

### DD

Use inbuilt `dd` command for simple sequential I/O performance measurements

### Bonnie++

1. For random tests
2. Attention: bonnie++ creates an enourmous read and write queue thus the load average will increase to 15+
3. https://www.jamescoyle.net/how-to/599-benchmark-disk-io-with-dd-and-bonnie

## Troubleshooting CPU utilisation Notes

1. Use `htop` which will already be installed

## Troubleshooting Network utilisation Notes

1. Can use `speedtest` which is already installed

## Ubuntu Package information

1. `sudo apt install <package>` - install package
2. `sudo apt remove <package>` - remove package
3. `sudo apt-cache search <package>` - search for package description
4. `dpkg -i <deb package>` - install deb file
5. `dpkg -L | grep <package>` - list all installed packages, search for
`<package>`
6. `dpkg-query -L <package>` - show what files are installed by package
7. `sudo update-alternatives --config php` - change binary used for PHP

## Profiling VIM to find plugin speed problems

[https://thoughtbot.com/blog/profiling-vim](https://thoughtbot.com/blog/profiling-vim)

Do all of:
1. `:profile start vim-profile.log` - starts profiling with log file name
2. ``:profile file *`` - mask for which vim-script files to profile, in this case
all of them
3. ``:profile func *`` - mask for which vim-script functions to profile, in this
case all of them
4. ``:e problemfile.php`` - edit the problem file to start the profiling process
5. `:qa` - when done quit vim and look at the log file
6. Open up `vim-profile.log` and search for 'Total time' to see the biggest
culprits

## Joplin commandline

1. Use the alias `notes` to open Joplin.
2. Navigate the panes using `<TAB>` key
3. Press enter on an existing note to open it in an editor
4. Type `tc` without `:` to toggle the maximisation levels of the console.
5. Type `:help` for basic help.
6. Type `:help keymap` for hotkeys.
7. Type `/<search term>` to search.
8. Type `mn` to create a new note.
9. Type `tm` to toggle metadata - user created time and lots of other metadata.
10. Write all notes using Markdown so they display optimally across all clients.
11. Press ``<DEL>`` to delete a selected note.

## JIRA Go Client

1. First you must setup the JIRA Go client with the API key as specified in
the documentation - https://github.com/ankitpokhrel/jira-cli
2. `issues` to show open issues allocated to you.
3. `board` to show the current JIRA board.

## Printing (on Ubuntu)

I have set up my laserjet to print from the command line via CUPS. This is useful
when printing out shopping lists etc, quickly.

1. `lp <file>` to print the file.
2. `echo bla | lp --` to print the pipe.

## fzf

`fzf` is installed. There are many things you can do with it. Here is a good source:

`https://andrew-quinn.me/fzf/`

## Remote Connection

To remotely SSH via preshared key SSH to my home server, assuming you have authentication
use the alias `hq`

## 24 bit colour

THIS is the best guide to enabling 24 bit colour on all terminal emulators
and tmux, that I've found:

[https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)

To test whether you have got a proper 24 bit colour setup, use this:

`~/.dotfiles/bin/24-bit-color.sh`

You should see colour fades with NO stepping, just a complete blend.

This script is run for you when you run the second deploy script.

## External Scripts

I have written a few helper scripts in ~/.dotfiles/bin

### `gg.sh`,`so.sh`, `ai.sh`, `re.sh`, `gg`, `so`, `ai`, `re`

You can pipe multiple lines of text to these scripts. They will look up the
result in:

`gg <google search>` - Google
`so <stack overflow search>` - Stack Overflow
`re <reddit search>` - Reddit
`ai <chatgpt search>` - ChatGPT (providing you have an API key)

The first three will open a new tab or web browser in Firefox (only works in Ubuntu)
with your query on those sites.

The last will output the result of the query to STDOUT, and also save the result
on your clipboard.

You can also use the three commands WITHOUT the extension to allow for easy `<cmd> <query>`
use while in an interactive console, for example

$ `ai <why are cornflakes crunchy>` - this will output on the terminal the answer to your q
and copy the result to the clipboard
$ `re <why are cornflakes crunchy>` - this will open a web browser with the query and search
reddit
$ `so <stackoverlow search>` - this will open a web browser with the query and search
$ `gg <why are cornflakes crunchy>` - this will open a web browser with the query and search
google

### `search-ebooks.sh <search terms>`

This searches my ThinkSation server for EPUB books according to a wildcard.
It then displays the results as a sorted list, so they can be opened by
epy which is a command-line EPUB reader.

### `clean-git-checkout.sh <path>`

This will find and delete all '.git' dirs under the <path>, which effectively
strips completely git from the checkout.

### `install-node.sh <major version>`

Installs nodejs via the Debian 'nodesource' repo, with a supplied <major version>
(for example, 20). This is the recommended way to install node.

### `make-and-install-vim.sh <version>`

Downloads and compiles a version matching `<version>` of VIM from:
https://www.mirrorservice.org/pub/vim/unix/

It makes sure it compiles it with Python3 support.

### `update-joplin-cli.sh`

Fetches and installs the latest verison of the Joplin CLI notetaking app.

### `fix-whitespace-problems.sh <path>`

When given a `<path>` it does the following to all files under that path:
1) Removes all newlines from the start of a file, and end of a file.
2) Removes all trailing whitespace from all lines of each file.

### `mlnx_tune`

Displays some diagnosic information about the ancient Mellonex SFP fibreoptic network
card in my server.

### `get-weather.sh`

Displays on the commandline a visual representation of the current weather in Manchester, UK.

### `secure-home-dir-perms.sh`

Sets the permissions of all the files in the current user's home directory to secure defaults.

### `hq-read-epub.sh <search terms>`

This remotely connects to my Linux server and searches my library of epub
books stored there with search terms, allows you to select one to open,
and then opens it in the command-line epy epub reader.

### `delete-all-docker-content.sh`

This will clean the local install of all docker containers, networks and images. This
is non-destructive as it doesn't actually uninstall docker, and you can just
docker pull them all again.

### `ai-files-purpose.zsh`

This will ask OpenAI to have a guess at the contents of each file in the current
directory based on their naming and some AI magic, and tell its guess for each
file. Often it is accurate but not always. Run it again for another guess.

### `ai-dir-purpose.zsh`

This will ask OpenAI to have a guess at the purpose of the current directory based
on the naming of the files in it, and some AI magic. Often it is accurate but not
always. Run it again for another guess.

### `osx.zsh`

Running this should get a virtualised OSX setup up and running, providing
you have about 50GB free, and a CPU that supports KVM virtualisation.

### `repos.sh`

![Alt text](https://i.imgur.com/U0h7a8F.png "repos.sh")

This is like the 'tree' command, it will descend downwards into the current
directory and show which branches the Git repositories under the current
directory are on.

It is useful for getting a general overview of a complex codebase and its
current checkout state.

### `blameline`

![Alt text](https://i.imgur.com/7kfUGNQ.png "blameline")

This shows a line-by-line git blame on a particular file, e.g. `blameline README.md`
showing the origin commit and a snippet of the commit message. Very useful
for finding how the contents of a file was created.

### `git logline`

![Alt text](https://i.imgur.com/iimaagl.png "git logline")

A compact summary of commits to a directory or file, e.g. `git logline
~/.dotfiles`

# Modifying

If you want, you can fork this repo, and base your config on this. If you have
any problems using these dotfiles please let me know and I can help you.
