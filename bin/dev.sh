#!/bin/bash

set -e
set -x

if [ -z "$1" ]; then
  echo "Usage: dev.sh <github project root>"
  exit 1
fi

if [ ! -d "$1/.git" ]; then
  echo "Error: $1 is not a github project"
  exit 1
fi

cd "$1"
tmuxinator start development

