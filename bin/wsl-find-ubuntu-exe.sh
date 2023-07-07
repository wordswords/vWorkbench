#!/bin/bash

set -x
set -e

sudo find /mnt/c -name 'ubuntu*.exe' -type f 2>/dev/null
echo "Now open an admin console and run this file to change settings"

