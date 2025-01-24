#!/bin/bash

token=$(cat ~/.config/tod.cfg | grep token | sed 's/.*"\([^"]*\)".*/\1/')
curl -s "https://api.todoist.com/rest/v2/labels" -H "Authorization: Bearer $token"

