#!/bin/bash

set -e
set -x

notebook=$(joplin ls / | fzf | awk '{print $1}')
joplin use ${notebook}
joplin ls -l | fzf | awk '{print $1}'

