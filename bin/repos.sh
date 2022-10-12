#!/bin/bash -e

find . -name '.git' -type 'd' -printf "[ %p ]" -exec /bin/bash -c "show-branch.sh {}" \; 2>/dev/null | egrep --color=always -v  '\[\]'
