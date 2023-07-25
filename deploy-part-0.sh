#!/bin/bash
# vim: foldmethod=marker foldmarker=report_progress,report_done

set -e
source ./deploy-common.sh

report_heading 'Deploy Prerequisites: Part 0'

# Must go before everything else
report_progress 'Checking locale'
     locale | grep -q LANG=en_GB.UTF-8 || ( echo 'en_GB.UTF-8 is not set as the locale. You need to fix this before proceeding.' && exit 1 )
report_done
report_progress 'Restoring last modified dates for .dotfiles'
    sudo apt-get install git-restore-mtime
    sudo git restore-mtime
report_done
report_progress 'Checking for existence of SECRETS directory'
if [[ ! -d ~/.dotfiles/SECRETS ]] ; then
    echo "ERROR: SECRETS directory does not exist.  Please create it and put your secrets in it."
    exit 1
fi
report_done
report_progress 'Creating ~/.secure directory'
    mkdir -p ~/.secure
report_done
report_progress 'Ensure home directory permissions are set securely'
   ~/.dotfiles/bin/secure-home-dir-perms.sh
report_done
report_progress 'Install Git'
    sudo apt-get install git -y
report_done
report_progress 'Clone hqconfig repository for server configuration'
    rm -rf ~/.hqconfig
    git clone git@github.com:wordswords/hqconfig.git ~/.hqconfig
    ln -s ~/.hqconfig ~/.dotfiles/hqconfig
report_done

# Main lines
report_progress 'Upgrade all packages/distro to latest version'
    sudo apt-get update -y && sudo apt-get dist-upgrade -y && sudo apt-get upgrade -y && sudo apt-get autoremove -y
report_done
report_progress 'Upgrade VIM to latest version using third-party repo'
    sudo add-apt-repository ppa:jonathonf/vim -y
    sudo apt-get update -y && sudo apt-get upgrade -y
    sudo apt-get install vim-gtk3 -y || sudo apt-get upgrade vim-gtk3 -y
report_done
report_progress 'Install Speedtest from ookla for testing network speed'
    curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
    sudo apt-get install speedtest -y
report_done
report_progress 'Install Python used for vim plugins'
    sudo apt-get install python3 -y
    sudo apt-get install python3-pip -y
    pip install --upgrade pip # upgrade python2 (!) pip
    pip3 install --upgrade pip # upgrade python3
report_done
report_progress 'Install latest open JDK used for LanguageTool'
    sudo apt-get install default-jdk -y
report_done
report_progress 'Install zsh the best shell (so far)'
    sudo apt-get install zsh -y
report_done
report_progress 'Install Ctags used for vim-fugitive'
    sudo apt-get install universal-ctags -y
report_done
report_progress 'Install net-tools used for network diagnostics'
    sudo apt-get install net-tools -y
report_done
report_progress 'Install fortune used for fortune cookie'
    sudo apt-get install fortune-mod -y
report_done
report_progress 'Install Ripgrewp used for :CocSearch'
    sudo apt-get install ripgrep -y
report_done
report_progress 'Install tree for showing directory structures'
    sudo apt-get install tree -y
report_done
report_progress 'Install w3m text browser for wikipedia2text'
    sudo apt-get install w3m -y
report_done
report_progress 'Install bat, a cat clone with syntax highlighting and Git integration'
    sudo apt-get install bat -y
report_done
report_progress 'Install curl for downloading from the web'
    sudo apt-get install curl -y
report_done
report_progress 'Install xclip and xsel for clipboard access'
    sudo apt-get install xclip xsel -y
report_done
report_progress 'Install tmux terminal multiplexer'
    sudo apt-get install tmux -y
report_done
report_progress 'Install Elixir for Elixir development'
    sudo apt-get install elixir erlang -y
report_done
report_progress 'Install Nmap for Network admin'
    sudo apt-get install nmap -y
report_done
report_progress 'Install asciicinema for screencasts'
    sudo apt-add-repository ppa:zanchey/asciinema -y
    sudo apt-get update
    sudo apt-get install asciinema -y
report_done
report_progress 'Install shfmt for shell script formatting'
    sudo apt-get install shfmt -y
report_done
report_progress 'Install shellcheck for shell script formatting'
    sudo apt-get install shellcheck -y
report_done
report_progress 'Install docker-compose'
    sudo apt-get install docker-compose  -y
report_done
report_progress 'Nuke current node install'
    sudo apt remove nodejs -y
    sudo apt remove npm -y
    sudo rm -rf /usr/lib/node_modules/*
    sudo rm /bin/node
    sudo rm /bin/nodejs
report_done
report_progress 'Installing latest nodejs'
    sudo apt install nodejs npm build-essential -y
    sudo chmod -R 775 /usr/lib/node_modules/ 2>/dev/null || true
report_done
export PATH="/usr/local/bin/:$PATH"
report_progress 'Install vint for vim script linting'
    pip3 install vint
report_done
report_progress 'Install write-good for markdown English betterment'
    npm install -g write-good
report_done
report_progress 'Install markdownlint-cli for markdown English betterment'
    npm install -g markdownlint-cli
report_done
report_progress 'Install yamllint'
    sudo apt install yamllint -y
report_done
report_progress 'Install jq'
    sudo apt install jq -y
report_done
report_progress 'Install Manchester Metrolink Commandline App for Tram times'
    cd ~/.dotfiles/bin
    wget https://github.com/ayubmalik/trams/releases/download/v1.2.0/trams-linux-amd64
    mv trams-linux-amd64 trams
    chmod u+x trams
report_done
report_progress 'Install MozillaVPN for VPN privacy'
    sudo add-apt-repository ppa:mozillacorp/mozillavpn -y
    sudo apt-get update -y
    sudo apt-get install mozillavpn -y
report_done

# custom installation lines
report_progress 'Installing McFly, a zsh Control-R replacement'
    curl -LSfs https://raw.githubusercontent.com/cantino/mcfly/master/ci/install.sh | sudo sh -s -- --force --git cantino/mcfly
report_done
report_progress 'Installing Delta, a git diff viewer'
    wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta_0.15.1_amd64.deb
    sudo dpkg -i git-delta_0.15.1_amd64.deb
    rm git-delta_0.15.1_amd64.deb
report_done
report_progress 'Installing cht.sh a command line help client'
    PATH_DIR="$HOME/bin"  # or another directory on your $PATH
    mkdir -p "$PATH_DIR"
    curl https://cht.sh/:cht.sh > "$PATH_DIR/cht.sh"
    chmod +x "$PATH_DIR/cht.sh"
report_done
report_progress 'Installing surfraw a command line google search client'
    sudo apt-get install surfraw surfraw-extra -y
report_done
report_progress 'Installing epy a command line epub reader'
    pip3 install git+https://github.com/wustho/epy
report_done

# os-specific lines
cur_os=$(get_os)
if [[ ${cur_os} == 'ubuntu' || ${cur_os} == 'osx' ]];
then
    report_progress 'Installing vim-anywhere for allowing text to be edited on any text input'
        curl -fsSL https://raw.github.com/cknadler/vim-anywhere/master/install | bash
    report_done
fi
if [[ ${cur_os} == 'ubuntu' ]];
then
    report_progress 'Installing workrave, a reminder app to take screenbreaks'
        sudo apt-get install workrave -y
    report_done
fi
if [[ ${cur_os} == 'windows' ]];
then
    report_progress 'Copying alacritty terminal emulator config to windows profile location for Windows user conta.. change if this is not your windows username'
        sudo mkdir -p /mnt/c/Users/conta/AppData/Roaming/alacritty
        sudo cp ~/.dotfiles/windows-terminal-emulators-config/windows-alacritty.yml  /mnt/c/Users/conta/AppData/Roaming/alacritty/alacritty.yml
    report_done
fi

report_progress 'We will now attempt to enable automated unattended-upgrades'
    sudo apt-get install unattended-upgrades -y
report_done

report_finished 'Deploy Prerequisites: Part 0 Complete'

