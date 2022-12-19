## [++ CUSTOM ZSH FUNCTIONS ++]

export USE_HARD_LINKS=false

syncnotes() {
    joplin-cli sync
}
autoload -Uz syncnotes

notes() {
    joplin-cli
}
autoload -Uz notes

updatedotfiles() {
    cd ~/.dotfiles
    git pull origin master | echo ''
    cd -
}
autoload -Uz updatedotfiles

fortuneprint() {
    echo "\n"
    echo -e "[-- \e[0;36m$(fortune)\e[0m --]"
    echo "\n"
}
autoload -Uz fortuneprint
## [-- CUSTOM ZSH FUNCTIONS --]


## [++ SOURCE REMOTE CONNECTION ALIASES ++]
source ~/.zsh_aliases
## [-- SOURCE REMOTE CONNECTION ALIASES --]

## [++ FOR RUST ++]
ls ~ | grep -q config >/dev/null 2>/dev/null && source "~/.cargo/env"
## [-- FOR RUST --
