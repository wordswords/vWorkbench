#!/usr/bin/env bash
# vim: foldmethod=marker foldmarker=report_progress,report_done
#
# Core installation and configuration of system tools, development
# environments and user applications.

set -euo pipefail

# Resolve the dotfiles directory so the script works from any cwd.
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
readonly DOTFILES_DIR

# shellcheck disable=SC1090,SC1091
source "${DOTFILES_DIR}/deploy-common.sh"
# shellcheck disable=SC1090,SC1091
source "${DOTFILES_DIR}/SECRETS/vimz_config.sh"

readonly DOTFILES_BIN="${DOTFILES_DIR}/bin"
readonly MONOKAI_REPO="git@github.com:shannonmoeller/vim-monokai256.git"

export PIP_BREAK_SYSTEM_PACKAGES=1

install_github_repository() {
    local repo_url=$1
    local dest_dir=${2:-$(basename "${repo_url}")}

    if [[ -d "${dest_dir}" ]]; then
        echo "Repository already exists at ${dest_dir}, pulling latest..."
        git -C "${dest_dir}" pull
    else
        echo "Cloning repository ${repo_url} to ${dest_dir}"
        git clone --depth 1 "${repo_url}" "${dest_dir}"
    fi
}

create_symbolic_link() {
    local source_path=$1
    local target_path=$2

    if [[ -e "${target_path}" ]]; then
        echo "Removing existing file/directory at ${target_path}"
        rm -rf "${target_path}"
    fi

    echo "Creating symlink from ${source_path} to ${target_path}"
    ln -sf "${source_path}" "${target_path}"
}

verify_github_access() {
    local check_file
    check_file="$(mktemp)"

    echo "Testing SSH connection to GitHub..."
    ssh -T git@github.com 2>"${check_file}" || true

    if grep -q 'successfully authenticated' "${check_file}"; then
        echo "GitHub access verified."
        rm -f "${check_file}"
    else
        echo "ERROR: Unable to authenticate with GitHub. Please check your SSH keys."
        rm -f "${check_file}"
        exit 1
    fi
}

remove_existing_dotfiles() {
    local files=(
        "$HOME/.vim"
        "$HOME/.vimrc"
        "$HOME/.bash_profile"
        "$HOME/.vim/coc-settings.json"
    )

    local file
    for file in "${files[@]}"; do
        if [[ -e "${file}" ]]; then
            echo "Removing ${file}"
            rm -rf "${file}"
        fi
    done
}

install_omz_plugins() {
    cd "$HOME/.oh-my-zsh/plugins" || return 1
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git || true
    git clone https://github.com/zsh-users/zsh-autosuggestions.git || true
    git clone https://github.com/agkozak/zsh-z.git || true
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf" || true
    yes | "$HOME/.fzf/install" || true
}

setup_symbolic_links() {
    mkdir -p "${DOTFILES_DIR}/.vim"

    create_symbolic_link "${DOTFILES_DIR}/.vim" "$HOME/.vim"
    create_symbolic_link "${DOTFILES_DIR}/.bash_aliases" "$HOME/.bash_aliases"
    create_symbolic_link "${DOTFILES_DIR}/.bash_aliases" "$HOME/.zsh_aliases"
    create_symbolic_link "${DOTFILES_DIR}/.bash_profile" "$HOME/.bash_profile"
    create_symbolic_link "${DOTFILES_DIR}/.bash_profile_remote" "$HOME/.bash_profile_remote"
    create_symbolic_link "${DOTFILES_DIR}/coc-settings.json" "$HOME/.vim/coc-settings.json"
    create_symbolic_link "${DOTFILES_DIR}/.tmux.conf" "$HOME/.tmux.conf"
    create_symbolic_link "${DOTFILES_DIR}/.vimrc" "$HOME/.vimrc"
    create_symbolic_link "${DOTFILES_DIR}/.zshenv" "$HOME/.zshenv"
    create_symbolic_link "${DOTFILES_DIR}/.zshrc" "$HOME/.zshrc"
}

install_texidote() {
    if [[ ! -f "${DOTFILES_DIR}/texidote.jar" ]]; then
        "${DOTFILES_BIN}/download-latest-texidote-jar.sh"
    fi
}

install_wikipedia2text() {
    rm -rf "${DOTFILES_DIR}/wikipedia2text" || true
    git clone git@github.com:chrisbra/wikipedia2text.git "${DOTFILES_DIR}/wikipedia2text"
    ln -sf "${DOTFILES_DIR}/wikipedia2text/wikipedia2text" "${DOTFILES_BIN}/wp2t"
}

install_github_cli() {
    if ! type -p wget >/dev/null; then
        sudo dnf update && sudo dnf install wget -y
    fi

    sudo mkdir -p -m 755 /etc/dnf/keyrings
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg |
        sudo tee /etc/dnf/keyrings/githubcli-archive-keyring.gpg >/dev/null
    sudo chmod go+r /etc/dnf/keyrings/githubcli-archive-keyring.gpg

    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/dnf/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" |
        sudo tee /etc/dnf/sources.list.d/github-cli.list >/dev/null

    sudo dnf update
    sudo dnf install gh -y
}

run_vim_plugins() {
    local script_file="${DOTFILES_DIR}/vimscript.vs"
    printf '%s\n' \
        ':PluginClean' \
        ':PluginInstall' \
        ':helptags ALL' \
        ':qa' >"${script_file}"
    vim -s "${script_file}"
    rm "${script_file}"
}

install_vim_colorscheme() {
    local tmp_dir
    tmp_dir="$(mktemp -d)"
    git clone "${MONOKAI_REPO}" "${tmp_dir}/colorscheme"
    mkdir -p "$HOME/.vim/colors/"
    mv "${tmp_dir}"/colorscheme/colors/* "$HOME/.vim/colors/"
    rm -rf "${tmp_dir}"
}

install_tmux_plugin_manager() {
    if [[ -d "$HOME/.tmux/plugins/tpm" ]]; then
        git -C "$HOME/.tmux/plugins/tpm" pull
    else
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi
}

configure_windows() {
    rm -rf "$HOME/windows-tools"
    git clone git@github.com:wordswords/windows-tools.git "$HOME/windows-tools"

    # Install alacritty.
    "$HOME/windows-tools/windows-terminal-emulators-config/install-alacritty-windows.sh"

    # Install win32yank for clipboard integration.
    cp "$HOME/windows-tools/windows-clipboard/win32yank.exe" "$HOME/.bin"

    local startup_dir="/mnt/c/Users/conta/AppData/Roaming/Microsoft/Windows/Start Menu/Programs/Startup"

    # Move mapped-drives batch file to startup.
    sudo cp "$HOME/windows-tools/map-network-drives/map-network-drives.bat" "${startup_dir}/"

    # Move the DNS reset batch file to startup.
    sudo cp "$HOME/windows-tools/vpn-dns-bat-files/hq.local DNS to internal network = RUN AS ADMIN.bat" "${startup_dir}/"

    # Install Windows11Debloat and set it to run at startup.
    (
        cd "$HOME/windows-tools/win11debloatsettings"
        ./install-debloat.sh
    )
}

configure_linux() {
    report_progress 'Installing workrave, a reminder app to take screenbreaks'
    sudo dnf install workrave -y || true
    report_done

    report_progress 'Install htop for CPU/RAM/process monitoring'
    sudo dnf install htop -y
    report_done

    # Disable sleep, suspend, hibernate and hybrid-sleep.
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target

    echo
    echo "-- OPTIONAL EXTRAS -- "
    echo

    local answer
    read -r -p "Benchmark your computer with hardinfo2 (equiv to Speccy)? (y/yes/N) " answer
    if [[ "${answer}" =~ ^[Yy] ]]; then
        "${DOTFILES_BIN}/install-hardinfo2-for-almalinux.sh"
        hardinfo2 | tee "$HOME/hardinfo2report.txt"
    fi

    read -r -p "Install/update the JIRA-CLI Go client? (y/yes/N) " answer
    if [[ "${answer}" =~ ^[Yy] ]]; then
        sudo snap install go --classic 2>/dev/null || sudo snap refresh go
        go install golang.org/dl/go1.19@latest
        go install github.com/ankitpokhrel/jira-cli/cmd/jira@latest
    else
        # Remove a previously installed Go JIRA client.
        rm -f "$HOME/go/bin/jira"
    fi
}

main() {
    report_heading 'Deploy Dotfiles: Part 2'

    report_progress 'Verifying GitHub access'
    verify_github_access
    report_done

    report_progress 'Removing existing dotfiles'
    remove_existing_dotfiles
    report_done

    report_progress 'Installing oh-my-zsh plugins'
    install_omz_plugins
    report_done

    report_progress 'Removing default ~/.zshrc'
    rm -rf "$HOME/.zshrc"
    report_done

    report_progress 'Setting up local bin directory'
    rm -rf "${HOME:?}/bin"
    mkdir -p "$HOME/bin"
    cp -furs "${DOTFILES_DIR}"/bin/* "$HOME/bin/"
    report_done

    report_progress 'Setting up symbolic links'
    setup_symbolic_links
    report_done

    report_progress 'Running ctags'
    ctags -R ./*
    report_done

    report_progress 'Installing bash-language-server through npm'
    sudo npm install -g bash-language-server
    report_done

    report_progress 'Install Texidote grammar checker'
    install_texidote
    report_done

    report_progress 'Install wikipedia2text'
    install_wikipedia2text
    report_done

    report_progress 'Install Github CLI tool'
    install_github_cli
    report_done

    report_progress 'Installing Powerlevel10k prompt'
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
        "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"/themes/powerlevel10k || true
    ln --force -s "${DOTFILES_DIR}/.p10k.zsh" "$HOME/.p10k.zsh" || true
    report_done

    report_progress 'Installing Vundle for vim'
    rm -rf "$HOME/.vim/bundle/Vundle.vim"
    git clone https://github.com/VundleVim/Vundle.vim.git "$HOME/.vim/bundle/Vundle.vim"
    report_done

    report_progress 'Running vim local commands for plugins'
    run_vim_plugins
    report_done

    local ycm_answer
    read -r -p "Install/update YouCompleteMe for VIM9 (slow on older systems)? (y/yes/N) " ycm_answer
    if [[ "${ycm_answer}" =~ ^[Yy] ]]; then
        report_progress 'Download, install and compile YouCompleteMe for VIM9'
        "${DOTFILES_BIN}/deploy-ycm.sh"
        report_done
    fi

    report_progress 'Register YCM Plugin Install for Vim9'
    printf '%s\n' ':PluginInstall' ':qa' >"${DOTFILES_DIR}/vimscript.vs"
    vim -s "${DOTFILES_DIR}/vimscript.vs"
    rm "${DOTFILES_DIR}/vimscript.vs"
    report_done

    report_progress 'Installing vim colorscheme'
    install_vim_colorscheme
    report_done

    report_progress 'Installing pynvim for python integration with vim'
    pip3 install --user pynvim
    pip3 install jedi
    report_done

    report_progress 'Setting default git config..'
    rm -f "$HOME/.gitconfig"
    cp "${DOTFILES_DIR}/.gitconfig" "$HOME/.gitconfig"
    git config --global user.email "${VIMZ_EMAIL}"
    set +x
    report_done

    report_progress 'Installing and configuring Joplin CLI notetaking app'
    "$HOME/bin/update-joplin-cli.sh"
    ln -f -s "$HOME/.joplin-bin/bin/joplin" "$HOME/bin/joplin"
    "$HOME/bin/joplin" config --import-file "${DOTFILES_DIR}/joplin.config"
    "$HOME/bin/joplin" config sync.10.password "${VIMZ_JOPLIN_SYNC_PASSWORD}"
    report_done

    report_progress 'Changing shell to /bin/zsh'
    sudo usermod -s /bin/zsh "$(whoami)"
    report_done

    report_progress 'Build and install Fortune-mod for Almalinux'
    "${DOTFILES_BIN}/build-and-install-fortune-mod-on-almalinux.sh"
    report_done

    report_progress 'Customising Fortune random quoter'
    "$HOME/bin/codelesscode-to-fortune.sh"
    report_done

    report_progress 'Stop unwanted changes dirtying up the dotfiles commit tracking'
    "$HOME/bin/clean-git-checkout.sh" "${DOTFILES_DIR}/.vim/pack/plugins/start/" || true
    git restore --staged "$HOME/.vim" || true
    report_done

    report_progress 'Installing tmux plugin manager'
    install_tmux_plugin_manager
    report_done

    report_progress 'Installing tmuxinator'
    sudo chown -R "${VIMZ_USER}" /var/lib/gems || true
    sudo gem install tmuxinator
    report_done

    report_progress 'Configuring tmuxinator'
    mkdir -p "$HOME/.config/tmuxinator"
    ln --force -s "${DOTFILES_DIR}/development.yml" "$HOME/.config/tmuxinator/development.yml"
    report_done

    report_progress 'Installing pandoc'
    "${DOTFILES_BIN}/install-pandoc.sh"
    report_done

    report_progress 'Install Cloudflare CLI speedtester'
    curl -fsSL https://raw.githubusercontent.com/kavehtehrani/cloudflare-speed-cli/main/install.sh | sh
    sudo mv "$HOME/.local/bin/cloudflare-speed-cli" /usr/local/bin
    report_done

    report_progress 'Install and setup vibe-coding env'
    "${DOTFILES_BIN}/deploy-vibe-coding-tools.sh"
    report_done

    local cur_os
    cur_os="$(get_os)"

    report_progress 'Running any Windows specific configuration'
    if [[ "${cur_os}" == 'windows' ]]; then
        configure_windows
    fi
    report_done

    report_progress 'Running any Linux specific configuration'
    if [[ "${cur_os}" == 'linux' ]]; then
        configure_linux
    fi
    report_done

    report_progress 'Outputting 24-bit console colour test'
    "${DOTFILES_BIN}/24-bit-color.sh"
    report_done

    report_progress 'Deploy Process: Complete'
    echo
    echo "-- NEXT STEPS -- "
    echo
    echo "Now just make sure that alacritty and the DroidSansM nerdfont are installed on your system."
    report_done

    report_heading 'All Done.'
}

main "$@"
