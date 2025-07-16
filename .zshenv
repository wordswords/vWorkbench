#[++ CUSTOM ZSH FUNCTIONS ++]

export USE_HARD_LINKS=false

syncnotes() {
    ~/bin/joplin sync
}
autoload -Uz syncnotes

notes() {
    ~/bin/joplin
}
autoload -Uz notes

updatedotfiles() {
    cd ~/.dotfiles >/dev/null 2>/dev/null
    git pull >/dev/null 2>/dev/null | echo ''
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

gissueview() {
    gh issue view "$@"
}
autoload -Uz gissueview

extipprint() {
    echo "[-- External IP location:"
    curl https://ifconfig.co/json 2>/dev/null | grep country_iso
    curl https://ifconfig.co/json 2>/dev/null | grep asn_org
    echo " --]"
}
autoload -Uz extipprint

tmuxsessionsprint() {
    echo "[-- Tmux sessions: \e[0;35m$(tmux ls 2>&1)\e[0m --]"
}
autoload -Uz tmuxsessionsprint

screensessionsprint() {
    echo "[-- Screen sessions: \e[0;35m$(screen -ls)\e[0m --]\n"
}
autoload -Uz screensessionsprint

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

tramsprint() {
    echo "\nTram times:\n"
    ~/.dotfiles/bin/trams display BRT
}
autoload -Uz tramsprint

ai() {
    echo "$@" | ai.sh
}
autoload -Uz ai

aisesh() {
    /usr/local/bin/chatgpt -i
}
autoload -Uz aisesh

gg() {
    gg.sh "$@" 
}
autoload -Uz gg

hack() {
    cd $1 && tmuxinator start development
}
autoload -Uz hack

so() {
    echo "$@" | so.sh
}
autoload -Uz so

re() {
    echo "$@" | re.sh
}
autoload -Uz re

checkdiskspace() {
    if [ "$(hostname)" = "hq" ]; then
        df -h | grep '.*/$' 2>/dev/null || true
        df -h | grep '/mnt' 2>/dev/null | grep -v docker | sort -h || true
    fi
    echo "\n"
}
autoload -Uz checkdiskspace

checkruns() {
    if [ "$(hostname)" = "hq" ]; then
        cat /home/david/.hqconfig/backup/.last_successful_backup_dump 2>/dev/null || true
        cat /home/david/.hqconfig/backup/.last_successful_backup_transfer 2>/dev/null || true
        cat /home/david/.hqconfig/music-organisation/.last_successful_music_import 2>/dev/null || true
        cat /home/david/.hqconfig/thor/.*thor* 2>/dev/null || true
        cat /home/david/.hqconfig/.last_successful_update_run 2>/dev/null || true
    fi
    echo "\n"
}
autoload -Uz checkbackup

getweather() {
    ~/.dotfiles/bin/get-weather.sh
}
autoload -Uz getweather

## [-- CUSTOM ZSH FUNCTIONS --]

. "$HOME/.cargo/env"
