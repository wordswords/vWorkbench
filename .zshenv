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
    git restore-mtime --force ~/.dotfiles/backup/.last_successful_backup_dump >/dev/null 2>/dev/null
    git restore-mtime --force ~/.dotfiles/backup/.last_successful_backup_transfer >/dev/null 2>/dev/null
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


extipprint() {
    echo "[-- External IP location:"
    curl https://ifconfig.co/json 2>/dev/null | grep zip_code
    curl https://ifconfig.co/json 2>/dev/null | grep city
    echo " --]"
}
autoload -Uz extipprint

tmuxsessionsprint() {
    echo "[-- Tmux sessions: \e[0;35m$(tmux ls 2>&1)\e[0m --]"
}
autoload -Uz tmuxsessionsprint

tramsprint() {
    echo "\nTram times:\n"
    ~/.dotfiles/bin/trams display BRT
}
autoload -Uz tramsprint

ai() {
    echo "$@" | ai.sh
}
autoload -Uz ai

gg() {
    gg.sh "$@" 
}
autoload -Uz gg

so() {
    echo "$@" | so.sh
}
autoload -Uz so

re() {
    echo "$@" | re.sh
}
autoload -Uz re

checkbackup() {
    if [ "$(hostname)" = "thinkstation.local" ]; then
        cat /home/david/.hqconfig/backup/.last_successful_backup_dump 2>/dev/null || true
        cat /home/david/.hqconfig/backup/.last_successful_backup_transfer 2>/dev/null || true
        cat /home/david/.hqconfig/music-organisation/.last_successful_music_import 2>/dev/null || true
    fi
    echo "\n"
}
autoload -Uz checkbackup

getweather() {
    ~/.dotfiles/bin/get-weather.sh
}
autoload -Uz getweather

## [-- CUSTOM ZSH FUNCTIONS --]

