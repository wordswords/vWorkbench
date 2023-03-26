#!/bin/zsh

set -e

BACKUP_FLAG_FILENAME=~/.dotfiles/backup/.last_successful_backup
RED="\e[0;31m"
GREEN="\e[0;36m"
NOCOLOR="\e[0m"
ERROR_MESSAGE="${RED}BACKUP FAILED - BACKUP HAS NOT BEEN COMPLETED IN THE PAST DAY - ${NOCOLOR}"
OK_MESSAGE="[-- ${GREEN}Backup seems OK${NOCOLOR} --]"

finally(){
    echo "\n"
    awk -i inplace '!seen[$0]++' ~/.zshrc
    exit 0
}
things_are_bad(){
    BAD_MESSAGE="* ${ERROR_MESSAGE} ***\n** ${ERROR_MESSAGE} **\n*** ${ERROR_MESSAGE} *"
    echo "echo \"${BAD_MESSAGE}\"" >> ~/.zshrc
    echo "${BAD_MESSAGE}"
    finally
}
things_are_ok(){
    echo "${OK_MESSAGE}"
    finally
}

if [ ! -e ${BACKUP_FLAG_FILENAME} ]
then
    things_are_bad
fi

if test `find "${BACKUP_FLAG_FILENAME}" -mtime +1`
then
    things_are_bad
else
    things_are_ok
fi

exit 1




