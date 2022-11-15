vim -c 'CocUpdateSync|q'
report_done


report_progress 'Installing pynvim for python integration with vim'
pip3 install --user pynvim
pip3 install jedi
report_done

report_progress 'Setting default git config.. change this if you are not David Craddock!'
rm ~/.gitconfig
set -x
git config --global alias.logline "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
git config --global commit.template ~/.dotfiles/.git-commit-template
git config --global core.editor vim
git config --global diff.tool vimdiff
git config --global merge.conflictstyle diff3
git config --global merge.tool fugitive
git config --global mergetool.fugitive.cmd 'vim -f -c "Gvdiffsplit!" "$MERGED"'
git config --global mergetool.keepBackup false
git config --global mergetool.prompt false
git config --global user.email "$( cat ~/.dotfiles/secretseadd | tr 'N-ZA-Mn-za-m' 'A-Za-z' )"
git config --global user.name "David Craddock"
set +x
report_done

report_progress 'Installing and configuring Joplin CLI notetaking app'
( which joplin-cli 2>/dev/null && sudo npm update -g joplin ) || ( NPM_CONFIG_PREFIX=~/.joplin-bin npm install -g joplin && sudo ln -s ~/.joplin-bin/bin/joplin /usr/bin/joplin-cli )
report_done

report_progress 'Import Joplin config'
( ls ~/.config | grep -q joplin >/dev/null || /usr/bin/joplin-cli config --import < ~/.dotfiles/joplin.config )
report_done

report_progress 'Creating SECURE_DIR if it doesnt already exist'
ls $SECURE_DIR || ( mkdir -p $SECURE_DIR )
report_done

report_progress 'Encrypting Joplin notes'
unlock && mkdir -p $SECURE_DIR/.config || echo '' && ( mv ~/.config/joplin $SECURE_DIR/.config/ 2>/dev/null || echo '' ) && ( ln -sf $SECURE_DIR/.config/joplin ~/.config/joplin )
report_done

report_progress 'Syncing Joplin notes, you will now be asked to log into dropbox'
syncnotes
report_done

report_progress 'Changing shell to /bin/zsh.'
sudo chsh -s $(which zsh 2>/dev/null) $(whoami)
report_done

report_progress 'Customising Fortune random quoter'
set -o extendedglob
sudo rm -rf "/usr/share/games/fortunes/*" || echo ''
set +o extendedglob
sudo tar xzf ~/.dotfiles/gaiman-fortunes.tgz -C /usr/share/games/fortunes/
report_done

echo
echo "-- OPTIONAL EXTRAS -- "
echo
read "?Do you want to install JIRA-CLI Go client? (y/N)? " JIRAINSTALL
if [[ ${JIRAINSTALL} == 'yes' || ${JIRAINSTALL} == 'y' || ${JIRAINSTALL} == 'Y' ]];
then
    sudo snap install go --classic 2>/dev/null || sudo snap refresh go
    go install golang.org/dl/go1.19@latest
    go install github.com/ankitpokhrel/jira-cli/cmd/jira@latest
    report_progress '''JIRA-CLI go client installed. You will now have to setup
    it with your local JIRA_API token, see: https://github.com/ankitpokhrel/jira-cli/'''
    report_done
fi
echo
read "?Do you want to install or update the Ubuntu snap images of Spotify and Morgen? (y/N)? " SNAPINSTALL
if [[ ${SNAPINSTALL} == 'yes' || ${SNAPINSTALL} == 'y' || ${SNAPINSTALL} == 'Y' ]];
then
    report_progress 'Installing Morgen calendar app via snap'
    sudo snap install morgen 2>/dev/null || sudo snap refresh morgen
    report_done

    report_progress 'Installing Spotify app via snap'
    sudo snap install spotify 2>/dev/null || sudo snap refresh spotify
    report_done
fi
echo
echo "-- NEXT STEPS -- "
echo
echo '''You will have to install your nerdfont manually, download
DroidSansNerdFontMono from https://github.com/ryanoasis/nerd-fonts . After this,
you will have to set your terminal emulator to use said font.'''

report_progress 'Deployment process finished'
report_done
