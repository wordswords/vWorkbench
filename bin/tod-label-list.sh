#!/bin/bash

token=$(cat ~/.config/tod.cfg | grep token | sed 's/.*"\([^"]*\)".*/\1/')
selectedlabel=$(curl -s "https://api.todoist.com/rest/v2/labels" -H "Authorization: Bearer $token" | grep name | grep -v GCal | xargs -n 1 | sed 's/.*"\([^"]*\)".*/\1/' | grep -v name | tr -d ',' | sort | fzf)
~/bin/tod-task-list.sh "${selectedlabel}" | sed "s/@ ${selectedlabel}//g"


