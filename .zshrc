## [++ OMZ Config ++]
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
set +x
export GPG_TTY=$(tty)
# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"
# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"
# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"
# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=7
# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"
# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"
# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"
# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"
# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"
# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder
# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# User configuration
# export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
# export MANPATH="/usr/local/man:$MANPATH"
source $ZSH/oh-my-zsh.sh
# You may need to manually set your language environment
# [START] lang CONFIG
export LANG=en_GB.UTF-8
export LANGUAGE=
export LC_CTYPE="en_GB.UTF-8"
export LC_NUMERIC="en_GB.UTF-8"
export LC_TIME="en_GB.UTF-8"
export LC_COLLATE="en_GB.UTF-8"
export LC_MONETARY="en_GB.UTF-8"
export LC_MESSAGES="en_GB.UTF-8"
export LC_PAPER="en_GB.UTF-8"
export LC_NAME="en_GB.UTF-8"
export LC_ADDRESS="en_GB.UTF-8"
export LC_TELEPHONE="en_GB.UTF-8"
export LC_MEASUREMENT="en_GB.UTF-8"
export LC_IDENTIFICATION="en_GB.UTF-8"
export LC_ALL=
# [END] lang CONFIG
# Preferred editor for local and remote sessions
export EDITOR=vim
export GIT_EDITOR=vim
# Compilation flags
# export ARCHFLAGS="-arch x86_64"
# ssh
export SSH_KEY_PATH="~/.ssh/id_rsa.pub"
# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(
  bundler
  docker
  git
  npm
  python
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-z
)
export LSCOLORS=gxfxbEaEBxxEhEhBaDaCaD
source ~/.oh-my-zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.oh-my-zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '≠' autosuggest-accept
# zsh-z
autoload -U compinit && compinit
zstyle ':completion:*' menu select
source ~/.oh-my-zsh/plugins/z/z.plugin.zsh
## [-- OMZ Config --]
## [++ PATHS ++]
export PATH="/usr/local/bin:/bin:/usr/bin:${HOME}/bin:${HOME}/.local/bin:${HOME}/go/bin:/usr/games:/home/david/.cargo/bin:/snap/bin"
export SECURE_DIR="${HOME}/.secure"
## [-- PATHS --]
## [++ SOURCE EMPLOYER-SPECIFIC SETTINGS ++]
set -o extendedglob
for f (~/.dotfiles/SECRETS/**/^*("~"|dpkg-(dist|old|new)|.(tmp|back|bak))(N.))  . $f 2>/dev/null
set +o extendedglob
## [-- SOURCE EMPLOYER-SPECIFIC SETTINGS --]
## [++ ALACRITTY CONFIG PATH ++]
export XDG_CONFIG_HOME="${HOME}/.config"
## [-- ALACRITTY CONFIG PATH --]
## [++ ALIASES ++]
( which jira >/dev/null 2>/dev/null ) && alias board="jira sprint list -s~Done" && alias issues="jira issue list -a$(jira me) -s~Done"
alias bat="batcat"
alias blameline='~/.dotfiles/bin/git-better-blame.sh'
alias colours='for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done;'
alias externalip="curl https://ifconfig.co/json ; echo"
alias firefox="/snap/bin/firefox"
alias grep="grep --color"
alias hq="ssh -p 608 david@hq.local"
alias rhq="ssh -p608 david@63.135.74.199"
alias iostat="pcp iostat"
alias l='ls -CF'
alias la='ls -A'
alias ll='ls -alF'
alias ls="ls --color"
alias path="echo \"$PATH\" | tr \":\" \"\n\" | nl"
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'
alias please='sudo $(fc -ln -1)'
alias ports="sudo netstat -tlpun | sort -t: -k2 -n"
alias vi="vim -u NONE"
alias htop="pcp atop"
alias top="pcp atop"
alias zshconfig="vim ~/.dotfiles/.zshrc && ~/.dotfiles/bin/deploy-zshrc.sh"
alias todo="tod list view --project Important | less"
alias gissues="gh issue list"
alias glogin="gh auth login"4
alias quicknmap="nmap -vv --min-rate 5000 -p- "

## [-- ALIASES --]
## [++ Required for Golang install syntax ++]
export GO111MODULE=on
## [-- Required for Golang install syntax --]
## [++ McFly Initialization ++]
export MCFLY_KEY_SCHEME=vim
(&>/dev/null eval "$(mcfly init zsh)" 2> /dev/null &)
## [-- McFly Initialization --]
## [++ Powerlevel10k prompt configuration ++]
source ~/.p10k.zsh
fpath=(~/.zsh.d/ $fpath)
## [-- Powerlevel10k prompt configuration --]
## [++ VISIBLE COMMANDS RUN ON EVERY INTERACTIVE SHELL ++]
updatedotfiles
fortuneprint
ttyprint
tmuxsessionsprint
screensessionsprint
extipprint
echo "\n"
checkruns
checkdiskspace
getweather
tramsprint
echo '' # BLANK LINE
## [-- VISIBLE COMMANDS RUN ON EVERY INTERACTIVE SHELL --]
#zprof #- Uncomment this to profile zsh startup

export TERM=xterm-256color
