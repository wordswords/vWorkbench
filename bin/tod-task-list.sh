#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

tod list view -f @"$1" | grep -v 'Important' | sed '/^$/d'

