#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Select a Todoist label via fzf and list its tasks.
todoist_token=$(grep token < "${HOME}/.config/tod.cfg" | sed 's/.*"\([^"]*\)".*/\1/')
selected_label=$(curl -s "https://api.todoist.com/rest/v2/labels" -H "Authorization: Bearer ${todoist_token}" | grep name | grep -v GCal | xargs -n 1 | sed 's/.*"\([^"]*\)".*/\1/' | grep -v name | tr -d ',' | sort | fzf)
"${HOME}/bin/tod-task-list.sh" "${selected_label}" | sed "s/@ ${selected_label}//g"

