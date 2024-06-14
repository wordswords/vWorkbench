#!/bin/bash

set -e
set -x

sudo rsync -avzh --remove-source-files --progress "${SOURCE}" "${DESTINATION}" && sudo find "${DESTINATION}" -type d -empty -delete

