# My Development Environment (Dotfiles)

Welcome to my customized development environment setup, crafted to enhance productivity and streamline workflows for software development. This setup is primarily tested on Kali Linux rolling and the latest version of Ubuntu under WSL2 on Windows 11. Compatibility with other platforms may require significant modifications.

![Workbench](workbench.jpg "Picture of a woodworker's workbench")

## Asciicinema Latest Demo

[![asciicast](https://asciinema.org/a/699666.svg)](https://asciinema.org/a/699666)

## Table of Contents

<!-- toc -->

  * [Overview](#overview)
  * [Maintaince](#maintaince)
  * [Features](#features)
    + [VIM Setup](#vim-setup)
    + [ZSH Configuration](#zsh-configuration)
  * [Installation and Updates](#installation-and-updates)
    + [Prerequisites](#prerequisites)
    + [Installation Steps](#installation-steps)
    + [What It Installs](#what-it-installs)
  * [Usage](#usage)
    + [Shell Shortcuts](#shell-shortcuts)
    + [VIM9 Shortcuts](#vim9-shortcuts)
  * [Clipboard Management](#clipboard-management)
  * [Command line GenAI Stuff](#command-line-genai-stuff)
  * [Aider](#aider)
  * [Productivity Shortcuts](#productivity-shortcuts)
    + [Tmux](#tmux)
      - [Preconfigured Tmuxinator 'Hack' session](#preconfigured-tmuxinator-hack-session)
      - [Tmux Shortcuts](#tmux-shortcuts)
    + [Tmux Pane Resize](#tmux-pane-resize)
  * [VIM Spellchecking and Grammar Checking](#vim-spellchecking-and-grammar-checking)
  * [VIM9 Leader Search Functions](#vim9-leader-search-functions)
    + [Visual Mode](#visual-mode)
  * [Git Fugitive Workflow](#git-fugitive-workflow)
  * [Git Fugitive Blame Window](#git-fugitive-blame-window)
  * [Git Fugitive Mergetool](#git-fugitive-mergetool)
  * [Massren - Mass rename](#massren---mass-rename)
  * [VIM's Inbuilt Terminal](#vims-inbuilt-terminal)
  * [VIM Modelines and Folds](#vim-modelines-and-folds)
  * [VIM Regex](#vim-regex)
  * [Wildcards for Searching and Editing](#wildcards-for-searching-and-editing)
  * [Processing Files with `:argdo`](#processing-files-with-argdo)
  * [GitHub Copilot](#github-copilot)
  * [Tagbar Plugin](#tagbar-plugin)
- [Additional Notes](#additional-notes)
  * [Tmux](#tmux-1)
  * [Git Tips](#git-tips)
  * [GNU Diff/Patch](#gnu-diffpatch)
  * [Python 3 Tips](#python-3-tips)
  * [Using Strace](#using-strace)
  * [Regular Expressions](#regular-expressions)
  * [Docker/Docker Compose](#dockerdocker-compose)
  * [Troubleshooting](#troubleshooting)
  * [Ubuntu Package Management](#ubuntu-package-management)
  * [Profiling VIM for speed problems](#profiling-vim-for-speed-problems)
  * [Joplin CLI](#joplin-cli)
  * [JIRA Go Client](#jira-go-client)
  * [NIX Internals Books](#nix-internals-books)
  * [Printing on Ubuntu](#printing-on-ubuntu)
  * [PCP - System Performance Co-Pilot](#pcp---system-performance-co-pilot)
  * [fzf](#fzf)
  * [GNU Parallel](#gnu-parallel)
  * [Format Conversion](#format-conversion)
  * [Common Grep Scripts](#common-grep-scripts)
  * [Remote Connection](#remote-connection)
  * [24-bit Colour](#24-bit-colour)
  * [External Scripts](#external-scripts)
  * [Modifying](#modifying)

<!-- tocstop -->

## Overview

This setup includes a variety of tools and configurations tailored for efficient development, such as a customized VIM setup, ZSH with Powerlevel10k, tmux, and the Alacritty terminal emulator. It integrates various productivity tools and shortcuts to optimize your workflow.

## Maintaince

At the moment, I'm using a 'rolling' release schedule, which means the many incompatibilities between different components of this setup are identified whenever I attempt to run the deploy script which updates the setup, and fixed and committed to trunk.

This means that when you check out this repository, there may be inconsistencies and bugs between the different components that are a result of the current versions of the components being separate to the ones I am currently using.

In the future, I might look to making more measured, self-contained releases. It is difficult though, as it requires me to isolate all the dependencies and statically snapshot them. I definitely think this is the way forward, but it's a lot of work, and in doing so it makes it less useful to me, because I wouldn't be able to rapidly get new updates and features in and use them for my own use. So I have held back on doing this.

If you do end up using this setup, or basing your setup in any way on this setup, I would appreciate any pull-requests you can make in an effort to make the repository more stable and less buggy.

## Features

### VIM Setup

![VIM Setup](https://i.imgur.com/K6fBzSH.png "VIM setup")

- **vim-airline**: Displays file issues, warnings, and errors.
- **NERDTree**: Visualizes git status with symbols for modified, staged, untracked, and more.

### ZSH Configuration

![ZSH Setup](https://i.imgur.com/oZmTLND.png "My zsh setup")

- **oh-my-zsh with Powerlevel10k**: Provides fast auto-completion and displays Git repo status. More details at [Powerlevel10k](https://github.com/romkatv/powerlevel10k).

## Installation and Updates

### Prerequisites

- **Git** authenticated with GitHub.
- **Locale set to `en_GB.UTF-8`** - `~/.dotfiles/bin/fix-locale.sh` may be needed to run manually, adjust as needed if you're outside the UK.

### Installation Steps

1. Clone the repository: `git clone git@github.com:/wordswords/vWorkbench ~/.dotfiles`
2. Navigate to the directory: `cd ~/.dotfiles/`
3. Prepare configuration in `~/.dotfiles/SECRETS` using templates from `~/.dotfiles/SECRETS_TEMPLATES`.
4. Run the deployment script: `./deploy.sh`

### What It Installs

- Customized VIM9 with numerous plugins, including GitHub Copilot.
- Oh-my-ZSH with ZSH as the default shell.
- Joplin CLI for note-taking (requires personal credentials).
- Optional applications like Morgen calendar and Golang JIRA CLI.
- Elixir development environment.
- Aider with ChatGPT for AI assistance.
- Fortune with Software Engineering Koan quotes.

Note: Customization may be required for full functionality. Consider using a Docker container or VM for testing.

## Usage

### Shell Shortcuts

- `<CTRL>-<R>`: Search previous commands with McFly.
- `z <directory>`: Change to a directory without typing `cd`.
- `l`: Long-style `ls`.
- `delta <file1> <file2>`: Two-way diff interface.
- `<tab>`: Activate oh-my-zsh autocomplete.
- `repos.sh`: Check branch names of all git repositories.
- `vi`: Load minimal VIM config.
- `notes`: Launch Joplin CLI.
- `please`: Repeat last command with `sudo`.
- `ports`: List open ports.
- `tree`: Display directory tree.
- `ref <jira issue>`: Open JIRA issue in Firefox.
- `lookup <jira issue>`: Print JIRA CLI ticket summary.
- `bat <file>`: Syntax-highlighted `cat`.
- `gg <query>`: Google search in Firefox.
- `so <query>`: Stack Overflow search in Firefox.
- `pstree`: Display process tree.
- `<CTRL-X> <CTRL-E>`: Open text editor in shell.
- `ai <query>`: Query ChatGPT and copy result to clipboard.
- `todo`: Open Todoist list.

### VIM9 Shortcuts

- `<leader> h`: Open this help document.
- `<TAB>`: Activate autocomplete plugins.
- `,`: Leader key for shortcuts.
- `<LEFT>`: Toggle NERDTree.
- `<RIGHT>`: Toggle Vista.
- `<DOWN>`: Open Quickfix list.
- `<UP>`: Open Location list.
- `>>`/`<<`: Adjust indentation.
- `set mouse=a`: Enable mouse support.
- `K`: View documentation for current term.
- `gd`: Go to definition.
- `:G <git command>`: Run git commands via vim-fugitive.
- `/`: Search across buffers.
- `u`: Move up a directory in NERDTree.
- `<F12>`: Toggle distraction-free mode.
- `:Format`: Format buffer with coc language server.
- `:Wordy<space><tab>`: Use Wordy proofreading tool.
- `:LanguageToolCheck`: Grammar and spelling check.
- `:<','>s/git clone/git submodule add/`: Replace `git clone` with `git submodule add`.
- `:'<,'>!sort`: Sort visual block lines.
- `:'<,'> norm i##`: Comment lines with `##`.
- `!ctags -R *`: Generate ctags index.
- `gx`: Open URL under cursor.
- `:%s/\s\+$//e`: Remove trailing whitespace.
- `:Prettier`: Run Prettier formatter.
- `%`: Skip to next code bracket.
- `>i{`: Indent code block.
- `:map`: Show key mappings.

For more details, see the [VIM Cheatsheet](https://github.com/wordswords/dotfiles/blob/master/notes/VIMCHEATSHEET.md).

## Clipboard Management

- `<Control-c>`: Copy in Gnome applications.
- `<Control-v>`: Paste in Gnome applications.
- `<Control-Shift-v>`: Paste in Gnome terminal.
- `<Control-a-{>`: Enter clipboard mode in tmux.
- `<Control-v>`: Paste in VIM.
- `y`: Yank to clipboard in VIM.
- `pbcopy`/`pbpaste`: Use in terminal pipes.
- `xclip.sh`: Alternative clipboard command.

## Command line GenAI Stuff

- `aisesh` - this opens an interactive prompt with the default model
- `ai '<prompt>'` - asks ChatGPT a question
- `fabric` - an advanced way of interacting with preset prompts

## Fabric

- You must setup Fabric completely in addition to the normal automated setup process. The command to do this is `fabric -S`. You need to input GenAI keys and other keys such as Youtube API keys.
- You need to install ffmpeg and yt-clip for video summaries
- Once setup, you can use the scripts such as `fabric-summarise-youtube-video.sh <complete youtube url>` to summarise video content, for example

## Aider

1.
- `aider`: Start interactive ChatGPT AI code assistant.
- When typing `hack <dir>` from the shell, Aider will watch the project directory for changes and provide assistance.

2.
- While Aider is watching the project directory:
- Writing a comment with `AI` at the end is an instruction for aider.
- Writing a comment with `AI!` at the end triggers aider to read all AI comments and make changes to your code.
- Writing a comment with `AI?` triggers aider to answer your question.

## Productivity Shortcuts
### Tmux

#### Preconfigured Tmuxinator 'Hack' session

- `hack <github project root directory>` will start up my default tmux configuration with Vim9 and Aider running in seperate panes.

#### Tmux Shortcuts

- To scroll within a pane, just use `<Control-a>` and afterwards use the arrow keys or pageup/pagedown.
- To move up/down/left/right between panes, just use VIM9 shortcuts, they will just 'work'.
- `<Control-a> r`: Reload config file.
- `<Control-a> -`: Create a new horizontal pane.
- `<Control-a> |`: Create a new vertical pane.
- `<Control-a> c`: Create a new window.
- `<Control-a> %`: Split the current pane vertically.
- `<Control-a> "`: Split the current pane horizontally.

### Tmux Pane Resize

- `<Control-a> <Control-RIGHT>`: Extend pane to the right.
- `<Control-a> <Control-DOWN>`: Extend pane down.
- `<Control-a> <Control-UP>`: Extend pane up.
- `<Control-a> <Control-LEFT>`: Extend pane to the left.
- `<Control-a> <SPACE>`: Switch pane arrangements.

## VIM Spellchecking and Grammar Checking

- `<LEFT>`: Toggle NERDTree.
- `<RIGHT>`: Toggle Vista.
- `<DOWN>`: Open Quickfix list.
- `<UP>`: Open Location list.
- `zg`: Mark word as correct.
- `zw`: Mark word as incorrect.
- `zug`: Unmark correct word.
- `zuw`: Unmark incorrect word.
- `z=`: Suggest correct spelling.
- `1z=`: Use first suggestion.
- `.`: Redo last replacement.
- `:spellr`: Repeat replacement for all matches.
- `<F12>`: Toggle 'Goyo' mode.

## VIM9 Leader Search Functions

- `<leader> h`: Access help file.
- `<leader> w`: Wikipedia lookup.
- `<leader> b`: Git blame lookup.
- `<leader> j`: JIRA issue lookup.
- `<leader> p`: Save file as Reddit post.
- `<leader> y`: Copy file to clipboard.
- `<leader> l`: Run LanguageToolCheck.
- `<leader> c`: Toggle Copilot.

### Visual Mode

- `<leader> g`: Google search selection.
- `<leader> s`: Stack Overflow search selection.

## Git Fugitive Workflow

- `:Git`: Interactive git status.
- `a`: Stage file.
- `d`: Unstage file.
- `:Git commit`: Commit staged files.
- `:Git push`: Push commit.
- `:Git diff`: Open diff.
- `g?`: Display help.
- `:q`: Close status window.

## Git Fugitive Blame Window

- `:Git blame`: Line-by-line blame.
- `Enter`: Open commit diff.
- `C`, `A`, `D`: Resize blame window.
- `g?`: Display help.

## Git Fugitive Mergetool

- Use `git mergetool` for conflicts.
- Navigate conflicts with `]c` and `[c`.
- Use `d2o` or `d3o` to resolve conflicts.
- Use `:wq` to save and exit.

## Massren - Mass rename

- Use `massren` to rename large numbers of files easily using VIM

## VIM's Inbuilt Terminal

- Run commands with `:term`.
- Use tmux for interactive terminals.

## VIM Modelines and Folds

- `zc`: Close fold.
- `zm`: Close all folds.
- `zn`: Open all folds.

## VIM Regex

- Use `\v` for "very magic mode" for when you need less escaping.
- `:help ordinary-atom` for regex syntax.
- Use `\1`, `\2` for capture groups.
- `.\{-}` for non-greedy match.

## Wildcards for Searching and Editing

- `:vimgrep /cat/ **/*.py`: Search files.
- `:e **/bla.py`: Open file.
- `:arg **/bla.py`: Edit multiple files.
- `:args`: Display arglist.

## Processing Files with `:argdo`

- `:arg`: Define arglist.
- `:argdo`: Execute command on arglist.
- `:args`: Describe arglist.

## GitHub Copilot

- `<leader> c`: Toggle Copilot.
- `<TAB>`: Accept autocomplete.

## Tagbar Plugin

- `<RIGHT>`: Load Tagbar.
- Navigate tags to jump to features.

# Additional Notes

## Tmux

## Git Tips

- `git status`: Check branch and changes.
- `git commit --amend`: Amend last commit.
- `git rebase -i HEAD~2`: Interactive rebase.
- `git branch`: List branches.
- `git stash push`: Stash changes.
- `git stash pop`: Apply stashed changes.
- `git checkout -b <branch>`: Create and switch branch.
- `git pull origin main`: Pull and merge main.
- `git difftool`: Use instead of `git diff`.
- `git mergetool`: Resolve merge conflicts.
- `blameline`: Line-by-line blame script.
- `git logline`: Custom log alias.
- `git checkout -- <file>`: Discard changes.
- `git checkout <hash> <file>`: Restore file from commit.

For more, see the [Git Book](https://git-scm.com/book/en/v2) and [Git Workflow](https://github.com/wordswords/dotfiles/blob/master/notes/GITWORKFLOW.md).

## GNU Diff/Patch

- Create patch: `diff -u <file1> <file2> > patch.diff`
- Apply patch: `patch -p1 < patch.diff`

## Python 3 Tips

- Use `ipython` for REPL.
- Debug with `import ipdb; ipdb.set_trace()`.
- Embed IPython with `import IPython; IPython.embed()`.

## Using Strace

- `strace <command>`: Trace system calls.
- `-f`: Follow child processes.

## Regular Expressions

- Use Perl for complex regex: `find . -name '*.html' -exec perl -i -pe "s/jpg\?/jpg/g" {} \;`
- Test regex online: [regexr.com](https://regexr.com/)

## Docker/Docker Compose

- `~/bin/delete-all-docker-content.sh`: Clean Docker content.
- `docker-compose --rm <service>`: Execute service defined in compose file.
- `docker ps`: List running containers.
- `docker-compose ps`: List services.
- `docker-compose run <service> <command>`: Run command in service.
- `docker logs <service>`: View logs.
- `docker build .`: Build container.
- `docker-compose up -d`: Start containers in background.
- `docker-compose logs -f <container>`: Tail logs.

For more, see [Docker Notes](https://github.com/wordswords/dotfiles/blob/master/notes/DOCKERNOTES.md).

## Troubleshooting

- Disk I/O: Use `iostat`, `fio`, `dd`, `bonnie++`.
- CPU: Use `htop`.
- Network: Use `iperf3`.
- `ports`- List open ports in sorted order.
- `sudo ufw status`- Check firewall status.

## Ubuntu Package Management

- `sudo apt install <package>`: Install package.
- `sudo apt remove <package>`: Remove package.
- `sudo apt-cache search <package>`: Search packages.
- `dpkg -i <deb>`: Install deb file.
- `dpkg-query -L <package>`: List package files.

## Profiling VIM for speed problems

- Start profiling: `:profile start vim-profile.log`
- Profile files: `:profile file *`
- Profile functions: `:profile func *`
- Edit file: `:e <file>`
- Quit and view log: `:qa`

## Joplin CLI

- Open Joplin: `notes`
- Toggle console: `tc`
- Navigate with `<TAB>`
- Create note: `mn`
- Toggle metadata: `tm`

## JIRA Go Client

- Setup with API key: [JIRA CLI](https://github.com/ankitpokhrel/jira-cli)
- Show issues: `issues`.
- Show board: `board`.

## NIX Internals Books

- [Lets Learn Tcpdump](https://github.com/wordswords/dotfiles/blob/master/notes/Lets%20Learn%20Tcpdump%20-%20Unknown.pdf)
- [Linux Debugging Tools](https://github.com/wordswords/dotfiles/blob/master/notes/Linux%20Debugging%20Tools%20-%20Unknown.pdf)
- [Networking ACK](https://github.com/wordswords/dotfiles/blob/master/notes/Networking%20Ack%20-%20Unknown.pdf)
- [Strace Book](https://github.com/wordswords/dotfiles/blob/master/notes/Spying%20Programs%20Strace%20-%20Unknown.pdf)
- [Profiling Tracing Perf](https://github.com/wordswords/dotfiles/blob/master/notes/Profiling%20Tracing%20Perf%20-%20Unknown.pdf)
- [So You Want To Be A Wizard](https://github.com/wordswords/dotfiles/blob/master/notes/So%20You%20Want%20To%20Be%20A%20Wizard%20-%20Unknown.pdf)
- [Bite Size Linux](https://github.com/wordswords/dotfiles/blob/master/notes/Bite%20Size%20Linux%20-%20Unknown.pdf)

## Printing on Ubuntu

- Print file: `lp <file>`.
- Print from pipe: `echo <text> | lp --`.

## PCP - System Performance Co-Pilot

- Install: `~/bin/install-pcp.sh`.
- Run dashboard: `pcp atop`.
- Run iostat: `pcp iostat`.

## fzf

- Installed for fuzzy finding. See [fzf guide](https://andrew-quinn.me/fzf/).

## GNU Parallel

- `echo <stream> | run-command-in-parellel <command>` can be used to parellelise jobs, eg:
- `echo Bla bla bla | run-command-in-parellel echo`

## Format Conversion

There are a bunch of scripts that take the hard work out of converting documents from one format to another, and also can be used to summarise youtube videos. They use 'Fabric' which is a set of maintained prompts that use GenAI models to summarise and convert data.

In the `~/.dotfiles/bin/` directory:

- `convert-epub-to-pdf.sh`
- `convert-mobi-to-pdf.sh`
- `convert-pdf-to-text.sh`
- `convert-text-to-markdown.sh`
- `fabric-clip-url-to-markdown.sh`
- `fabric-summarise-youtube-video-with-no-subtitles.sh`
- `fabric-summarise-youtube-video.sh`

All do roughly what you might expect.

## Common Grep Scripts

Scripts for common content you will want to grep from files:

- `grep-for-emailadds-in-file.sh <file>`
- `grep-for-ipadds-in-file.sh <file>`
- `grep-for-urls-in-file.sh <file>`


## Remote Connection

- SSH to home server from local network: `hq`.
- SSH to home server from remote network: `rhq`.

## 24-bit Colour

- Guide: [24-bit Colour Setup](https://gist.github.com/andersevenrud/015e61af2fd264371032763d4ed965b6)
- Test script: `~/.dotfiles/bin/24-bit-color.sh`

## External Scripts

These are installed in `~/bin`:

- `gg.sh`, `so.sh`, `ai.sh`, `re.sh`: Search scripts for Google, Stack Overflow, Reddit, ChatGPT.
- `search-ebooks.sh`: Search EPUB books.
- `clean-git-checkout.sh`: Remove `.git` directories.
- `install-node.sh`: Install Node.js.
- `make-and-install-vim.sh`: Compile VIM.
- `update-joplin-cli.sh`: Update Joplin CLI.
- `fix-whitespace-problems.sh`: Fix whitespace issues.
- `get-weather.sh`: Display weather.
- `secure-home-dir-perms.sh`: Secure home directory permissions.
- `hq-read-epub.sh`: Read EPUB books.
- `delete-all-docker-content.sh`: Clean Docker content.
- `ai-files-purpose.zsh`: Guess file purposes.
- `ai-dir-purpose.zsh`: Guess directory purpose.
- `osx.zsh`: Setup virtualized OSX.
- `repos.sh`: Show Git branches.
- `blameline`: Line-by-line git blame.
- `git logline`: Compact commit summary.

## Modifying

Feel free to fork this repo and customize it. If you encounter any issues, please reach out for assistance.
