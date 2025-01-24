#!/bin/bash

token=$(cat ~/.config/tod.cfg | grep token | sed 's/.*"\([^"]*\)".*/\1/')
echo curl -vs "https://api.todoist.com/rest/v2/labels" -H "Authorization: Bearer $token" 2>&1 | grep token

