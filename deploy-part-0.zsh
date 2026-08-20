#!/bin/zsh
# vim: foldmethod=marker foldmarker=report_progress,report_done
#
# Install all prerequisite packages, programs and utilities for the
# deploy process, then back up and reset existing dotfiles.

set -eu

# Resolve the dotfiles directory so the script works from any cwd.
DOTFILES_DIR="${0:A:h}"
readonly DOTFILES_DIR

# shellcheck disable=SC1090,SC1091
source ./deploy-common.sh

cur_os="$(get_os)"

# Install a set of system packages with a single progress "step".
# Each argument is a package name. Uses -q to suppress the repetitive
# "already installed / nothing to do" output that otherwise floods the log.
install_dnf_packages() {
    local title=$1
    shift
    report_progress "${title}"
    sudo dnf install -y -q "$@"
    report_done
}

# Back up a dotfile entry, tolerating files that don't exist yet.
backup_dotfile() {
    local src=$1
    local dst=$2
    # Remove any previous backup so stale files don't linger, then copy.
    rm -rf "${dst}"
    cp -RL "${src}" "${dst}" 2>/dev/null || echo "INFO: Could not backup ${src}, does it exist?"
}

report_heading 'Deploy Prerequisites: Part 0'

# Cache sudo credentials once up front, and refresh the dnf metadata a single
# time, so the dozens of subsequent `dnf install` calls don't each re-prompt
# for sudo or re-check metadata.
sudo -v
sudo dnf -q makecache

# We deliberately risk breaking system packages for newer pip tooling.
export PIP_BREAK_SYSTEM_PACKAGES=1

report_progress 'Checking for existence of SECRETS directory'
if [[ ! -d "${DOTFILES_DIR}/SECRETS" ]]; then
    echo "SECRETS directory does not exist. Please create it and put your secrets in it. Running config tool:"
    "${DOTFILES_DIR}/bin/setup-secrets-dir.sh"
fi
source "${DOTFILES_DIR}/SECRETS/vimz_config.sh"
report_done

report_progress 'Upgrade all packages/distro to latest version'
sudo "${HOME}/.dotfiles/bin/update-all-packages-locally.sh"
report_done

report_progress 'Creating ~/.secure directory'
mkdir -p "$HOME/.secure"
report_done

install_dnf_packages 'Install Git' git
install_dnf_packages 'Install Make and g++' make g++

# Back up and clean.
report_progress 'Backing up existing dotfiles to ~/.olddotfiles'
sudo rm -rf "$HOME/.olddotfiles"
mkdir -p "$HOME/.olddotfiles"
backup_dotfile "$HOME/.vim" "$HOME/.olddotfiles/.vim"
backup_dotfile "$HOME/.oh-my-zsh" "$HOME/.olddotfiles/.oh-my-zsh"
backup_dotfile "$HOME/.zshrc" "$HOME/.olddotfiles/.zshrc"
backup_dotfile "$HOME/.zshenv" "$HOME/.olddotfiles/.zshenv"
backup_dotfile "$HOME/.bash_profile" "$HOME/.olddotfiles/.bash_profile"
backup_dotfile "$HOME/.bash_aliases" "$HOME/.olddotfiles/.bash_aliases"
backup_dotfile "$HOME/.vimrc" "$HOME/.olddotfiles/.vimrc"
report_done

report_progress 'Removing existing zsh config'
rm -f "$HOME/.zshrc"
rm -f "$HOME/.zshenv"
rm -rf "$HOME/.oh-my-zsh"
report_done

report_progress 'Removing existing vim config'
rm -rf "$HOME/.vim"
report_done

report_progress 'Creating vim backup file directory structure'
mkdir -p "$HOME/.backup/vim/swap"
mkdir -p "$HOME/.backup/vim/undos"
report_done

# Main package installs.
report_progress 'Installing snap'
sudo dnf install -y -q snapd
report_done

report_progress 'Download compile and install VIM9 on AlmaLinux'
sudo dnf install -y -q ncurses-devel
"${DOTFILES_DIR}/bin/make-and-install-vim.sh" "${VIM_VERSION:-9.2.0272}"
report_done

report_progress 'Install Python used for vim plugins'
sudo dnf install -y -q python3 python3-pip
pip3 install --upgrade pip
report_done

# Build a Python >= 3.12, which YouCompleteMe requires. AlmaLinux 9 ships
# Python 3.9 as `python3`, so this compiles 3.12+ to /usr/local/bin/python3.12
# (see deploy-ycm.sh's YCM_PYTHON resolution).
report_progress 'Build Python 3.12 for YouCompleteMe'
"${DOTFILES_DIR}/bin/compile-python-almalinux.sh" "${PYTHON_VERSION:-3.12.0}"
report_done

report_progress 'Install latest open JDK used for LanguageTool'
sudo dnf install -y -q java-latest-openjdk
report_done

install_dnf_packages 'Install Ruby, used for a few things' ruby
install_dnf_packages 'Install zsh the best shell (so far)' zsh

report_progress 'Install right type of Ctags used for vim plugins'
sudo dnf install -y -q ctags
report_done

report_progress 'Build and install fortune-mod for Almalinux 10' 
${DOTFILES_DIR}/bin/build-and-install-fortune-mod-on-almalinux.sh 
report_done

install_dnf_packages 'Install net-tools used for network diagnostics' net-tools
install_dnf_packages 'Install Ripgrep used for :CocSearch' ripgrep
install_dnf_packages 'Install tree for showing directory structures' tree
install_dnf_packages 'Install w3m text browser for wikipedia2text' w3m
install_dnf_packages 'Install bat, a cat clone with syntax highlighting' bat
install_dnf_packages 'Install curl for downloading from the web' curl

report_progress 'Install xclip and xsel for clipboard access'
sudo dnf install -y -q xclip xsel
report_done

install_dnf_packages 'Install tmux terminal multiplexer' tmux

report_progress 'Install tmux terminal multiplexer and dev session config'
sudo gem install tmuxinator
rm -rf "$HOME/.config/tmuxinator/"
mkdir -p "$HOME/.config/tmuxinator"
cp "${DOTFILES_DIR}/.tmuxinator.development.yml" "$HOME/.config/tmuxinator/development.yml"
report_done

report_progress 'Install Erlang/OTP'
sudo "${DOTFILES_DIR}/bin/install-erlang-almalinux.sh" "${ERLANG_OTP_VERSION:-29.0.5}"
report_done

report_progress 'Install Elixir for Elixir development'
sudo "${DOTFILES_DIR}/bin/install-elixir-almalinux.sh" "${ELIXIR_VERSION:-1.20-latest}"
report_done

install_dnf_packages 'Install Nmap for Network admin' nmap

report_progress 'Install asciicinema for screencasts'
pip3 install asciinema
report_done

report_progress 'Install shfmt for shell script formatting'
"${DOTFILES_DIR}/bin/install-shfmt-almalinux.sh"
report_done

install_dnf_packages 'Install shellcheck for shell script formatting' shellcheck

report_progress 'Install ChatGPT CLI client'
pip install shell-gpt --break-system-packages
report_done

report_progress 'Installing node'
if [[ "${cur_os}" == windows || "${cur_os}" == linux ]]; then
    "${DOTFILES_DIR}/bin/install-node.sh"
fi
report_done

report_progress 'Install vint for vim script linting'
pip3 install vint
report_done

report_progress 'Install write-good for markdown English betterment'
sudo npm install -g write-good
report_done

report_progress 'Install markdownlint-cli for markdown English betterment'
sudo npm install -g markdownlint-cli
report_done

report_progress 'Install yamllint'
sudo dnf install -y -q yamllint
report_done

report_progress 'Install jq'
sudo dnf install -y -q jq
report_done

report_progress 'Install fnm node.js version manager'
"${DOTFILES_DIR}/bin/install-fnm.sh"
report_done

report_progress 'Install Joplin GUI desktop for integration with Browser plugin'
if [[ "${cur_os}" == linux ]]; then
    wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
fi
report_done

report_progress 'Installing McFly, a zsh Control-R replacement'
curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --force --git cantino/mcfly
report_done

report_progress 'Installing Delta, a git diff viewer'
"${DOTFILES_DIR}/bin/install-git-delta-almalinux.sh"
report_done

report_progress 'Installing surfraw a command line google search client'
"${DOTFILES_DIR}/bin/install-surfraw-almalinux.sh"
report_done

report_progress 'Installing epy a command line epub reader'
pip3 install git+https://github.com/wustho/epy
report_done

report_progress 'Installing AWS CLI'
"${DOTFILES_DIR}/bin/install-aws-cli.sh"
report_done

install_dnf_packages 'Installing Rust and Cargo' cargo
install_dnf_packages 'Installing Cmake for compiling YCM' cmake

report_progress 'Install calibre for mobi to PDF conversion'
"${DOTFILES_DIR}/bin/install-calibre-via-flatpak-almalinux.sh"
report_done

report_progress 'Install Fabric for AI unixy prompt commands'
curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash
report_done

report_progress 'Install mass rename tool'
go install github.com/laurent22/massren@latest
"$(go env GOPATH)/bin/massren" --config editor vim
report_done

report_progress 'Install yt-clip for downloading youtube videos'
"${DOTFILES_DIR}/bin/install-yt-clip.sh"
report_done

install_dnf_packages 'Install iotop for io load monitoring' iotop

report_finished 'Deploy Prerequisites: Part 0 Complete'
