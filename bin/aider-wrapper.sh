#!/bin/bash

set -e
set -x

source "/home/david/aider-venv/bin/activate"
aider --model deepseek --edit-format whole --architect
