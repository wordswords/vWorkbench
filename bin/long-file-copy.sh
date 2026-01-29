#!/bin/bash

set -e
set -x

SOURCE="$1"
DESTINATION="$2"

sudo rsync -avzh --progress "${SOURCE}" "${DESTINATION}"

