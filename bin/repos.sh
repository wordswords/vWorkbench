#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# Lists every `.git` directory under the current directory, showing the current
# branch for each via the `show-branch.sh` helper. Empty results are suppressed.

find . -name '.git' -type 'd' -printf '[ %p ]' \
    -exec /bin/bash -c "show-branch.sh {}" \; 2>/dev/null \
    | grep -E --color=always -v '\[\]'
