#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Checks all SUID files or programs to see if they're writeable, and outputs
# the matches in a friendly and useful format. Pass `-v` to also list safe
# (non-writeable) SUID binaries with their last-modified time.

modified_within_days="7"            # How far back (in days) to check for modified cmds.
verbose_mode=0                      # By default, let's be quiet about things.

if [[ $# -gt 0 && "$1" == "-v" ]]; then
    verbose_mode=1                  # User specified `-v`, so let's be verbose.
fi

# find -perm looks at the permissions of the file: 4000 and above
# are setuid/setgid.

find / -type f -perm /4000 -print0 | while read -d '' -r path 2>/dev/null
do
    if [[ -x "$path" ]]; then

        # Let's split file owner and permissions from the ls -ld output.

        owner="$(ls -ld "$path" | awk '{print $3}')"
        writable_perms="$(ls -ld "$path" | cut -c5-10 | grep 'w')"

        if [[ -n "$writable_perms" ]]; then
            echo "**** $path (writeable and setuid $owner)"
        elif [[ -n "$(find "$path" -mtime -"$modified_within_days" -print)" ]]; then
            echo "**** $path (modified within $modified_within_days days and setuid $owner)"
        elif [[ "$verbose_mode" -eq 1 ]]; then
            # By default, only dangerous scripts are listed. If verbose, show all.
            lastmod="$(ls -ld "$path" | awk '{print $6, $7, $8}')"
            echo "     $path (setuid $owner, last modified $lastmod)"
        fi
    fi
done

exit 0
