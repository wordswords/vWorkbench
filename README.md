# My .dotfiles

My setup with custom settings for bash, zsh and vim, with some extra `~/bin`
helper scripts for good measure. Tested on Ubuntu 22.04 and the latest Lubuntu.
I test this on my two main Linux computers, and my work Linux laptop.

## Demo Video

[![Watch the video](https://img.youtube.com/vi/09ZJYe0kRT4/0.jpg)](https://www.youtube.com/watch?v=09ZJYe0kRT4)


## VIM:

![Alt text](https://i.imgur.com/K6fBzSH.png "VIM setup")

### How to Decode the vim-airline Buffer Statusline

Full docs: [https://github.com/vim-airline/vim-airline](https://github.com/vim-airline/vim-airline)

1. The problems in the file are noted in the far right. If there are no problems
there will be no red or orange expanded sections.

* Orange - Warnings
* Red - Errors

2. It will show you how many warnings or errors there are, and the line number of
the first one. You should be able to skip between warnings/errors with the
`<Left>` and `<Right>` keys.

3. When you are searching through the file with `/` then it shows you: your term,
how many matches there are of your term, and which one you're on.

4. Other info displayed includes File Format, file type detected, current line of
code / total lines of code, current column number / total columns, and so on.

5. When it shows 'SPELL' is on, it is checking text spellings in addition to any
code related errors. To toggle this, use `:set nospell` or `:set spell`. It
highlights spelling errors in comments.

### How to decode Nerdtree file status symbols

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

## ZSH:

![Alt text](https://i.imgur.com/yBs7bKu.png "My zsh setup")

ZSH uses oh-my-zsh in Powerlevel10k mode, which provides fast and responsive
auto-complete options. Just hit `<TAB>` to autocomplete. It will also show the status
of the current Git repo.

https://github.com/romkatv/powerlevel10k

# Installation / Updating

The scripts are designed to install for the first time OR update the current
version. When you install my .dotfiles every time you log into a console, it
will fetch down the latest master from this repo. If there are any changes, you
are advised to rerun the scripts in 'Install Steps' below to keep your copy
uptodate.

## Installation Requirements for .dotfiles

* You have to use a ‘Nerd font’ - this is a specially patched font with extra
symbol characters for use in vim. This is not a prerequisite, it will show you
how to install it at the end of the dotfile deployment.
* There are many others. You can run a script that will attempt to install
the prerequisites under Ubuntu by executing `./deploy-part-0.sh`.

## What It Will Install

It will install my VIM9 development environment and anything else I use
regularly in my work. Currently it includes:

* Install my heavily customised version of VIM9 with coc.vim and other plugins
* Install latest version of Oh-my-ZSH and set your default shell to ZSH
* Install Joplin the command-line open source Evernote replacement, and secure
it with encryption, and download all my notes (presuming you are me).
* Ask if you want to install my usual apps - https://Morgen.so : a paid multiplatform
calendar app that I use with Google Calendar and Spotify. These are delivered
via the snap installation process.
* Ask if you want to install the excellent Golang JIRA CLI client which makes
navigating JIRA boards less painful.
* Setup 'fortune' with random Neil Gaiman quotes displayed on login.

You may well have to customise, mix and match, and edit these individual
settings because  you won't have the authentication required for this whole
process to work. If you are serious about reusing what I've done, I would
advise running this setup in a docker container or virtual machine.

## Install Steps

1. `git clone git@github.com:/wordswords/dotfiles ~/.dotfiles`
2. `cd ~/.dotfiles/`
3. `./deploy-part-0.sh` to attempt to install preqs
4. `./deploy-part-1.sh` to install and setup oh-my-zsh
5. Press `control-D` to drop out of oh-my-zsh
6. `./deploy-part-2.zsh` to install the vast majority of the customisations
7. By default it sets your git email address to be my address.
You probably want to change this if you're not me!
8. It will also attempt by default to log in to my Joplin account, which will
not succeed without my credentials. So you probably want to change that.

# Using the Dotfiles Environment

## Shell shortcuts

The most important command is `cht <language/tech/cmd> <query>` which will answer a
lot of questions with examples on common use. It requires internet access.

1. `<CTRL>-<R>` for an intelligent search through previous commands using McFly.
2. Type `z` and a directory name accessible from your current directory to cd to
that directory, no need to type cd.
3. Type `l` for a long-style ls.
4. `delta <file1> <file2>` for a nice 2 way diff style interface where you can
analyse and easily copy changes between files.
for then using on a website form.
5. Use `<tab>` to activate oh-my-zsh's autocomplete plugins. For example `git
<tab>`
6. Run `repos.sh` to check the branch name of all git repositories under the
current directory. Very useful when you have a number of different projects
that interact with each other and you want to quickly see which repos branches
you have checked out.
7. Use `vi` instead of `vim` to load a separate minimal vim config, useful if
    there are problems with the vim config.
8. Use `notes` to launch Joplin, my note-taking app.
9. Use `please` after realising that you needed sudo with the last command, to
    repeat the last command with sudo
10. Use `ports` to list the open ports on the system in a readable way.
11. Use `tree` for a handy diagram of the full directory tree under the current
directory.
12. Use `ref <jira issue number, no prefix>` to open firefox with the details
of that issue.
13. Use `lookup <jira issue number, no prefix>` to print the jira-cli ticket
summary of that issue on the command line.
14. Use `bat <file>` for a syntax-highlighting quick cat.
15. Use `hn` to get the top 10 Hacker News Network headlines for the hour.
16. Use `hn100` to get the top 100 Hacker News Network headlines for the hour.
17. Use `ddg <search query>` from the terminal to open a Firefox browser with the
query in the DuckDuckGo search engine.
18. Use `pstree` for a nice graph showing all processes and subprocesses running.

## VIM9 shortcuts

The most important VIM shortcut is `<leader> h` which is currently mapped to `, h`.
This will open up this document, which is kept up to date.

1. `<TAB>` to activate autocomplete plug ins.
2. `,` is set to be the `<leader>` key in VIM9, use it to trigger shortcuts.
3. `<LEFT>` and `<RIGHT>` cursor arrows to move through the syntax errors.
4. `<UP>` to toggle the file browser/NERDTree buffer.
5. `<DOWN>` to open the Vista file navigation.
6. `>>` and `<<` to adjust indentation.
7. `set mouse=a` is on, if you have any problems with copying and pasting just
`:set mouse=` beforehand.
8. `K` to bring up documentation on the current term and use the mouse wheel to
scroll the info.
9. `gd` to go to the definition of function or class.
10. `:G <git command>` to run a git command via vim-fugative, for example
`git diff`, `git add`.
11. Use `/` and start typing to quickly jump to a certain term across all open
buffers.
12. Use `u` to go up a root directory on nerdtree.
13. Use `<F12>` to toggle distraction-free writing mode.
13. Use `:Format` to format a buffer by the coc language server's prettifier,
where it exists.
15. Type `:Wordy<space><tab>` to use the Wordy proofreading tool to check for
poor words while writing.
16. Type `:LanguageToolCheck` to use the command-line grammar and spelling
checker (requires Java 8).
17. To search all instances of `git clone` and replace them with `git submodule
add` on a visual block, use `:<','>s/git clone/git submodule add/`.
18. To feed a visual block through an external command, for example, the NIX
external sort command, `:'<,'>!sort` - this will sort the visual block lines
alphabetically.
19. To execute a command on all lines in a visual block, use the norm
command, for example: `:'<,'> norm i##` after selecting in visual mode to comment
all lines out with a `##`. For the reverse, to uncomment and delete the first
character, use `:'<,'> norm x` after selecting in visual mode.
20. To generate a ctags index for all functions/methods in all languages, run
this command at the root of the source control repo `!ctags -R *`. Then you can
use `gd` to jump to the original definition of the function in any file.
21. If in some modes the backtick character does not insert, try typing it twice
that should insert it properly.
22. To open the URL under the cursor in the default browser use `gx` <- handy!
23. To remove all trailing white space from a file, use `:%s/\s\+$//e` <- handy!
24. To run Prettier on language servers that support this VS Code prettier,
use `:Prettier`
25. ``:%norm vipJ`` to unwrap all the text in the document (opposite to
word-wrap)
26. `%` when positioned over a code bracket to skip to the next code bracket
27. `>i{` when positioned over a code bracket to ident the code up to the next
code bracket
28. `:map` to show the keymappings made by your plugins and .vimrc. Note this is
somewhat difficult to follow.
29. `*` and `#` will search forward and backward through the file with the exact
same word that is under the cursor in normal mode.

[https://github.com/wordswords/dotfiles/blob/master/notes/VIMCHEATSHEET.md](https://github.com/wordswords/dotfiles/blob/master/notes/VIMCHEATSHEET.md)

## The Clipboard

Under Ubuntu, there are two clipboards, for some crazy reason that I don't understand.

As part of the installation of the this environment, Gnome is attempted to be patched
via a hook, to synchronise these clipboards.

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

### Firefox Shortcuts

I install vinium on Firefox which allows you to use the VIM shortcuts on most pages

1. `<h> <j> <k> <l>` to scroll as per normal in vim.
2. `gg` to go to the top of the page
3. `G` to go to the bottom of the page
4. `d` to scroll down half a page
5. `u` to scroll up half a page
6. `t` to open a new tab
7. `T` to search through your open tabs
8. `<Control>-<Alt>-v` while focused on an input element to open gVIM. When you write and save
the buffer in gVIM it will copy it to the clipboard and focus on the box you have left,
so you can quickly insert it in the text input on
the browser.
9. `<Control>-l` move the focus to the url box so you can type in a url

## VIM Spellchecking/Grammar checking/Proofreading commands (also Joplin notes)

1. `<LEFT>`       - prev text error
2. `<RIGHT>`      - next text error
3. `<UP>`         - toggle Nerdtree
3. `<DOWN>`       - toggle Vista
5. `<F1>`         - Run `:LanguageToolCheck`, a Java-based spelling and grammar checker
6. `zg`           - Mark as a good word
7. `zw`           - Like `zg` but mark the word as a wrong (bad) word
8. `zug`          - Unmark as good word
9. `zuw`          - Unmark as wrong (bad) word
10. `z=`           - For the word under/after the cursor suggest correctly spelled
words
11. `1z=`         - Use the first suggestion, without prompting
12. `.`           - Redo - repeat last word replacement
13. `:spellr`     - Repeat the replacement done by `z=` for all matches with the
replaced word in the current window
14. `<F12>`       - Toggle 'Goyo' distraction-free mode.

[![asciicast](https://asciinema.org/a/518234.svg)](https://asciinema.org/a/518234)

## Coc.vim Shortcuts on large software projects

Coc.vim is meant to provide an approximate mapping for Visual Studio Code's
plugins and IntelliSense features onto VIM9 and Neovim. It does this with various
degrees of compatibility. Often these features are not currently documented and require
prior knowledge of how the Code editor does things. This URL is the documentation
for the Code editor:
[https://docs.microsoft.com/en-us/visualstudio/ide/navigating-code?view=vs-2022](https://docs.microsoft.com/en-us/visualstudio/ide/navigating-code?view=vs-2022)

This is an excellent introduction to Coc.vim's objectives: [https://samroeca.com/coc-plugin.html](https://samroeca.com/coc-plugin.html)

1. `:CocDiagnostics` to show the errors in the current language server.
2. `<LEFT>` for the prev diagnostic error, this should be on any programming
language server.
3. `<RIGHT>` for the next diagnostic error, this should be on any programming
language server.
4. `:CocRename` for language server assisted refactoring by renaming a constant,
e.g. method, variable etc.
5. `gd` to jump to the definition of the language object under the cursor.
6. `gy` to jump to the type definition of the language object under cursor.
7. `gi` to jump to the implementation of the language object under cursor.
8. `gr` to show all references to the language object under cursor.
9. `K` for the language feature under the cursor to pull up the language server
documentation for that feature.
10. `:help coc-nvim` for the reference documentation for Coc.vim

## VIM9 Popup Functions

For any of these, use `<CTRL>-f` and `<CTRL>-b` to scroll the popups.

First move the cursor over a word or line and then:

1. `<leader> w` to lookup the current single word on wikipedia
2. `<leader> b` to lookup the current line with git blame
3. `<leader> j` to lookup the current issue number under cursor with jira-cli

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
3. Buffers are setup so `[YOUR local branch (2) | resulting mergefile (1) | THEIR merge in branch (3) ]`
4. Use `]c` and `[c` to navigate through the conflicts
5. Use the center pane to navigate. use `d2o` to obtain from YOUR local branch, use `d3o` to obtain from THEIR branch.
6. OR go to local branch OR merge in branch, select the conflict, and use `dp` to choose that version.
7. When done, use `:wq`

More info:
[https://www.youtube.com/watch?v=iPk4nOLj8w4](https://www.youtube.com/watch?v=iPk4nOLj8w4)

## VIM's inbuilt terminal

1. You can run arbitrary commands such as ``:term ls -al`` and see the results in
an updating terminal.
2. It is recommended that if you want an interactive terminal, use a tmux split.
This is because the paste functionality doesn't work too great while in VIM9 terminal.
Also it has problems running some terminal applications while run under VIM9 in tmux.

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
strip a document of all its html tags use this: `:%s/<.\{-}>/ /g`.

## Wildcards for searching and editing files and directories

1. You can search across a bunch of files with the following syntax:
`:vimgrep /cat/ **/*.py` will search for all instances of 'cat' in all the
python files down from the current path.
2. You can open a file without knowing the directory it is in, as long as it is
below the current directory, by `:e **/bla.py`. This will search for a file
'bla.py' recursively from the current directory.  If there is more than one file
found, it will error.
3. `help file-search` for more wildcard options
4. If you want to edit a number of files called bla.py, use `:arg **/bla.py`.
This will open all the files one by one, use `:next` to edit the next file in
the list. Use `:prev` to reopen a file previously edited. `:last` and `:first`
also work, and `:args` displays the whole list.


## Processing lots of files with `:argdo`

You can process a number of files using arglist in VIM.

1. `:arg` defines the arglist
2. `:argdo` allows you to execute a command on all the files in the arglist
3. `:args` describes the list of files in the arglist

For example if we wanted to replace all instances of 'animal' in every Python
file recursively from the current path, we would do the following:

`:arg **/*.py`
`:argdo **/\<animal\>/creature/qa | update`

``**/*.py`` selects all python files down from the current dir recurisvely
`:argo` executes a command on all files from current dir recurisvely.
`%s/\<animal\>/creature/qa` replaces every occurance of 'animal' with 'creature'
in every file - `a`, without raising errors if the matches are not found - `q`
`update` saves the file only if it has been modified

## Github Copilot

The Github copilot plugin is installed. It assumes you have a subscription.

1. `:Copilot enable` to enable autocompletes for the current buffer.
2. `:Copilot disable` to disable autocompletes for the current buffer.
3. `<TAB>` to accept current autocomplete.

## ChatGPT OpenAI CLI Plugin

1. You have to configure the plugin first by `mkdir -p ~/.dotfiles/SECRETS/ && echo export OPENAI_ACCESS_TOKEN=<your token> > ~/.dotfiles/SECRETS/openai-access-token.sh`
2. Then, just use `ai <query>` anywhere in your pipe, for example `cat bla.json | ai 'pretty print this json'` the result will be copied to the clipboard
and also output on the pipe
3. Other examples of use can be found at [https://github.com/Aesthetikx/openai_pipe](https://github.com/Aesthetikx/openai_pipe)

## Vista Plugin

Vista is used for coc.vim or ctags specific function lists for quickly jumping
around large projects.

1. `:Vista` to load up the right sidebar
2. `:Vista coc` to use coc.vim to provide the tags list
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

## Git stuff I keep forgetting

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
14. Use Github PR's 'changed files' tab for exactly what has changed, but don't
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

## Docker/Docker Compose stuff I forget

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

Also checkout the notes I took from the Docker Deep Dive book here:
[https://github.com/wordswords/dotfiles/blob/master/notes/DOCKERNOTES.md](https://github.com/wordswords/dotfiles/blob/master/notes/DOCKERNOTES.md)

## Ubuntu Package Stuff

1. `sudo apt install <package>` - install package
2. `sudo apt remove <package>` - remove package
3. `sudo apt-cache search <package>` - search for package description
4. `dpkg -i <deb package>` - install deb file
5. `dpkg -L | grep <package>` - list all installed packages, search for
`<package>`
6. `dpkg-query -L <package>` - show what files are installed by package
7. `sudo update-alternatives --config php` - change binary used for php

## Profiling VIM to find plugin speed problems

[https://thoughtbot.com/blog/profiling-vim](https://thoughtbot.com/blog/profiling-vim)

Do all of:
1. `:profile start vim-profile.log` - starts profiling with log file name
2. `:profile file *` - mask for which vim-script files to profile, in this case
all of them
3. `:profile func *` - mask for which vim-script functions to profile, in this
case all of them
4. `:e problemfile.php` - edit the problem file to start the profiling process
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
11. Press ```<DEL>``` to delete a selected note.

## JIRA Go Client

1. First you must setup the JIRA Go client with the API key as specified in
the documentation - https://github.com/ankitpokhrel/jira-cli
2. `issues` to show open issues allocated to you.
3. `board` to show the current JIRA board.

## External Scripts

I have written a few helper scripts in ~/.dotfiles/bin

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
for figuring out how a file was put together.

### `git logline`

![Alt text](https://i.imgur.com/iimaagl.png "git logline")

A compact summary of commits to a directory or file, e.g. `git logline
~/.dotfiles`

# Modifying

If you want, you can fork this repo and base your config on this. If you have
any problems using these dotfiles please let me know and I can help you.
