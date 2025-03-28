# My Development Environment (Dotfiles)

Welcome to my customized development environment setup, crafted to enhance productivity and streamline workflows for software development. This setup is primarily tested on Kali Linux rolling and the latest version of Ubuntu under WSL2 on Windows 11. Compatibility with other platforms may require significant modifications.

![Workbench](workbench.jpg "Picture of a woodworker's workbench")

## Asciicinema Latest Demo

[![asciicast](https://asciinema.org/a/699666.svg)](https://asciinema.org/a/699666)

## Table of Contents

- [Overview](#overview)
- [Features](#features)
  - [VIM Setup](#vim-setup)
  - [ZSH Configuration](#zsh-configuration)
  - [Alacritty Terminal](#alacritty-terminal)
- [Installation and Updates](#installation-and-updates)
  - [Prerequisites](#prerequisites)
  - [Installation Steps](#installation-steps)
- [Usage](#usage)
  - [Shell Shortcuts](#shell-shortcuts)
  - [VIM9 Shortcuts](#vim9-shortcuts)
- [Additional Notes](#additional-notes)
  - [Clipboard Management](#clipboard-management)
  - [Aider](#aider)
  - [Productivity Shortcuts](#productivity-shortcuts)
  - [Git Fugitive Workflow](#git-fugitive-workflow)
  - [Git Tips](#git-tips)
  - [Troubleshooting](#troubleshooting)
  - [Ubuntu Package Management](#ubuntu-package-management)
  - [Joplin CLI](#joplin-cli)
  - [JIRA Go Client](#jira-go-client)
  - [NIX Internals Books](#nix-internals-books)
  - [Printing on Ubuntu](#printing-on-ubuntu)
  - [PCP - System Performance Co-Pilot](#pcp-system-performance-co-pilot)
  - [Remote Connection](#remote-connection)
  - [External Scripts](#external-scripts)
  - [Modifying](#modifying)

## Overview

This setup includes a variety of tools and configurations tailored for efficient development, such as a customized VIM setup, ZSH with Powerlevel10k, tmux, and the Alacritty terminal emulator. It integrates various productivity tools and shortcuts to optimize your workflow.

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
- **Locale set to `en_GB.UTF-8`** - adjust as needed if you're outside the UK.
- **Secrets Directory**: Create `~/.dotfiles/SECRETS` with necessary credentials and API keys.
- **Alacritty**: Recommended for WSL2 users before installation.

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
- Fortune with Alan Moore quotes.

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

## Aider

- `aider`: Start interactive ChatGPT AI code assistant.
- When using tmuxinator's 'hack' project, Aider will watch the project directory for changes and provide assistance.

- When Aider is watching the project directory:
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
- Navigate with `<TAB>`.
- Create note: `mn`.
- Toggle metadata: `tm`.

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
