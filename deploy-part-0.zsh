#!/bin/zsh
# vim: foldmethod=marker foldmarker=report_progress,report_done

# This script is intended to install all the pre-requisite packages
# programs, and utilites for the deploy process. Wherever possible
# this should be in apt package format. 
#
# Sometimes it doesn't make sense for continuity reasons to not have
# ALL apt installs in this file, some are in deploy-part-2.sh as well, 
# but ideally all should live in this file.

#set -e
source ./deploy-common.sh
cur_os=$(get_os)
report_heading 'Deploy Prerequisites: Part 0'

## We want to take that risk
export PIP_BREAK_SYSTEM_PACKAGES=1

# Must go before everything else
#report_progress 'Checking locale'
#     locale | grep -q LANG=en_GB.UTF-8 || ( ( locale | grep -q LANG=en_GB.utf8 || echo 'en_GB.UTF-8/utf8 is not set as the locale. You need to fix this before proceeding.' && exit 1 ) )
#report_done

report_progress 'Upgrade all packages/distro to latest version'
    sudo /home/${VIMZ_USER}/.dotfiles/bin/update-all-packages-locally.sh
report_done

#if [[ $cur_os == 'windows' ]] ; then
#    report_progress 'Upgrading to a new LTS2 ubuntu release if available'
#        sudo apt install ubuntu-release-upgrader-core -y
#        sudo do-release-upgrade -d || echo 'There is no new LTS release available at present.'
#    report_done
#fi

report_progress 'Checking for existence of SECRETS directory'
if [[ ! -d ~/.dotfiles/SECRETS ]] ; then
    echo "SECRETS directory does not exist.  Please create it and put your secrets in it. Running config tool:"
    ~/.dotfiles/bin/setup-secrets-dir.sh
fi
source ~/.dotfiles/SECRETS/vimz_config.sh
report_done

report_progress 'Creating ~/.secure directory'
    mkdir -p ~/.secure
report_done

report_progress 'Ensure home directory permissions are set securely'
   #~/.dotfiles/bin/secure-home-dir-perms.sh
report_done

report_progress 'Install Git'
   sudo dnf install git -y
report_done

report_progress 'Install Make and g++'
    sudo dnf install make g++ -y
report_done


# Backup and clean
report_progress 'Backing up existing dotfiles to ~/.olddotfiles'
    sudo rm -rf ~/.olddotfiles
    mkdir -p ~/.olddotfiles
    cp -RL ~/.vim ~/.olddotfiles/.vim || echo "INFO: Could not backup .vim dir, does it exist?"
    cp -RL ~/.zsh* ~/.olddotfiles/ || echo "INFO: Could not backup .zsh*, do they exist?"
    cp -RL ~/.bash* ~/.olddotfiles/ || echo "INFO: Could not backup .bash*, do they exist?"
    cp -RL ~/.oh-my-zsh ~/.olddotfiles/ || echo "INFO: Could not backup .oh-my-zsh directory, does it exist?"
    cp -L ~/.bash_aliases ~/.olddotfiles/.bash_aliases || echo "INFO: Could not backup .bash_aliases, does it exist?"
    cp -L ~/.bash_profile ~/.olddotfiles/.bash_profile || echo "INFO: Could not backup .bash_profile, does it exist?"
    cp -L ~/.vimrc ~/.olddotfiles/.vimrc || echo "INFO: Could not backup .vimrc, does it exist?"
report_done

report_progress 'Removing existing zsh config'
    rm -f ~/.zshrc
    rm -f ~/.zshenv
    rm -rf ~/.oh-my-zsh
report_done

report_progress 'Removing existing vim config'
    rm -rf ~/.vim
report_done

report_progress 'Creating vim backup file directory structure'
    mkdir -p ~/.backup/vim/swap || echo "INFO: Swapfile backup directory seems to be already there."
    mkdir ~/.backup/vim/undos || echo "INFO: Undofile backup directory seems to be already there."
report_done


# Main lines
report_progress 'Installing snap'
    sudo dnf install snapd  -y
    sudo systemctl enable --now snapd apparmor
report_done

report_progress 'Download compile and install VIM9 on Ubuntu'
    sudo dnf install libncurses-dev  -y
    ~/.dotfiles/bin/make-and-install-vim.sh 9.2.0272
report_done

report_progress 'Install Python used for vim plugins'
    sudo dnf install python3  -y
    sudo dnf install python3-pip  -y
    pip install --upgrade pip # upgrade python2 (!) pip
    pip3 install --upgrade pip # upgrade python3
report_done

report_progress 'Install latest open JDK used for LanguageTool'
    sudo dnf install default-jdk  -y
report_done

report_progress 'Install Ruby, used for a few things'
    sudo dnf install ruby  -y
report_done

report_progress 'Install zsh the best shell (so far)'
    sudo dnf install zsh  -y
report_done

report_progress 'Install right type of Ctags used for vim plugins'
    sudo dnf remove exuberant-ctags  -y | true
    sudo dnf install universal-ctags  -y
report_done

report_progress 'Install net-tools used for network diagnostics'
    sudo dnf install net-tools  -y
report_done

report_progress 'Install fortune used for fortune cookie'
    sudo dnf install fortune-mod  -y
report_done

report_progress 'Install Ripgrewp used for :CocSearch'
    sudo dnf install ripgrep  -y
report_done

report_progress 'Install tree for showing directory structures'
    sudo dnf install tree  -y
report_done

report_progress 'Install w3m text browser for wikipedia2text'
    sudo dnf install w3m  -y
report_done

report_progress 'Install bat, a cat clone with syntax highlighting and Git integration'
    sudo dnf install bat  -y
report_done

report_progress 'Install curl for downloading from the web'
    sudo dnf install curl  -y
report_done

report_progress 'Install xclip and xsel for clipboard access'
    sudo dnf install xclip  -y
    sudo dnf install xsel  -y
report_done

report_progress 'Install tmux terminal multiplexer'
    sudo dnf install tmux  -y
report_done

report_progress 'Install tmux terminal multiplexer and dev session config'
    sudo gem install tmuxinator
    rm -rf ~/.config/tmuxinator/
    mkdir -p ~/.config/tmuxinator 
    cp ~/.dotfiles/.tmuxinator.development.yml ~/.config/tmuxinator/development.yml
report_done
report_progress 'Install Elixir for Elixir development'
    sudo dnf install elixir  -y
    sudo dnf install erlang  -y
report_done

report_progress 'Install Nmap for Network admin'
    sudo dnf install nmap  -y
report_done

report_progress 'Install asciicinema for screencasts'
    pip3 install asciinema
report_done

report_progress 'Install shfmt for shell script formatting'
    sudo dnf install shfmt  -y
report_done

report_progress 'Install shellcheck for shell script formatting'
    sudo dnf install shellcheck  -y
report_done

report_progress 'Install ChatGPT CLI client'
    pip install shell-gpt --break-system-packages
report_done

report_progress 'Installing node'
if [[ $cur_os == 'windows' ]] ; then
    ~/.dotfiles/bin/install-node.sh
fi
if [[ $cur_os == 'linux' ]] ; then
    # for kali linux only
    ~/.dotfiles/bin/install-node.sh
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
    sudo apt install yamllint  -y
report_done

report_progress 'Install jq'
    sudo apt install jq  -y
report_done

report_progress 'Install fnm node.js version manager'
    ~/.dotfiles/bin/install-fnm.sh
report_done

report_progress 'Install Joplin GUI desktop for integration with Browser plugin'
    if [[ $cur_os == 'linux' ]] ; then
      wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash
    fi
report_done


report_progress 'Installing McFly, a zsh Control-R replacement'
    curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --force --git cantino/mcfly
report_done

report_progress 'Installing Delta, a git diff viewer'
    wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta_0.15.1_amd64.deb
    sudo dpkg -i git-delta_0.15.1_amd64.deb
    rm git-delta_0.15.1_amd64.deb
report_done

report_progress 'Installing surfraw a command line google search client'
    sudo dnf install surfraw  -y
    sudo dnf install surfraw-extra  -y
report_done

report_progress 'Installing epy a command line epub reader'
    pip3 install git+https://github.com/wustho/epy
report_done

report_progress 'Installing AWS CLI'
    ~/.dotfiles/bin/install-aws-cli.sh
report_done

report_progress 'Installing Rust and Cargo'
    sudo dnf install cargo  -y
report_done

report_progress 'Installing Cmake for compiling YCM'
    sudo dnf install cmake  -y
report_done

report_progress 'Install calibre for mobi to PDF conversation'
    sudo dnf install calibre  -y
report_done

report_progress 'Install Fabric for AI unixy prompt commands'
    curl -fsSL https://raw.githubusercontent.com/danielmiessler/fabric/main/scripts/installer/install.sh | bash
report_done

report_progress 'Install mass rename tool'
    go install github.com/laurent22/massren@latest
    massren --config editor vim
report_done

report_progress 'Install yt-clip for downloading youtube videos'
    ~/.dotfiles/bin/install-yt-clip.sh
report_done

report_progress 'Install iotop for io load monitoring'
    sudo dnf install iotop  -y
report_done

report_progress 'We will now attempt to enable automated unattended-upgrades'
    sudo dnf install unattended-upgrades  -y
report_done



report_finished 'Deploy Prerequisites: Part 0 Complete'
