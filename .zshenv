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
    cd ~/.dotfiles >/dev/null 2>/dev/null
    git pull >/dev/null 2>/dev/null | echo ''
    git restore-mtime --force ~/.dotfiles/backup/.last_successful_backup &|>/dev/null
    cd - >/dev/null 2>/dev/null
}
autoload -Uz updatedotfiles

fortuneprint() {
    echo "\n"
    echo -e "[-- \e[0;36m$(fortune)\e[0m --]"
    echo "\n"
}
autoload -Uz fortuneprint

ttyprint() {
    echo "[-- Current TTY: \e[0;35m${GPG_TTY}\e[0m --]"
}
autoload -Uz ttyprint

tmuxsessionsprint() {
    echo "[-- Tmux sessions: \e[0;35m$(tmux ls 2>&1)\e[0m --]"
    echo "\n"
}
autoload -Uz tmuxsessionsprint

ai() {
    openai_pipe $@ | tee >(pbcopy)
}
autoload -Uz ai

gg() {
    SURFRAW_graphical_browser="/snap/bin/firefox" SURFRAW_graphical=yes SURFRAW_lang="uk" sr google $@
}
autoload -Uz gg

so() {
    SURFRAW_graphical_browser="/snap/bin/firefox" SURFRAW_graphical=yes SURFRAW_lang="uk" sr stack $@
}
autoload -Uz so

check_backup() {
    ~/.dotfiles/backup/check-for-failed-backup.zsh
}
autoload -Uz check_backup

## [-- CUSTOM ZSH FUNCTIONS --]

## [++ FOR RUST ++]
ls ~ | grep -q config >/dev/null 2>/dev/null && source "~/.cargo/env"
## [-- FOR RUST --
