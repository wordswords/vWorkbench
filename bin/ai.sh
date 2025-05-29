#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
sgpt "${input}" 2>/dev/null


