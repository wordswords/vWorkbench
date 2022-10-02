## [++ CUSTOM ZSH FUNCTIONS ++]

export USE_HARD_LINKS=false

lockup() {
  sudo umount $SECURE_DIR
}
autoload -Uz lockup

unlock() {
    ( sudo mount | grep -q .secure ) || ( sudo mount -t ecryptfs -o ecryptfs_cipher=aes,ecryptfs_key_bytes=32,ecryptfs_passthrough=no,ecryptfs_enable_filename_crypto=yes,no_sig_cache $SECURE_DIR $SECURE_DIR )
}
autoload -Uz unlock

syncnotes() {
    unlock
    joplin-cli sync
    lockup
}
autoload -Uz syncnotes

notes() {
    unlock
    joplin-cli
    lockup
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

