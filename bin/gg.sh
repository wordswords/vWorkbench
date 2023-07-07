#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
SURFRAW_graphical_browser="firefox-esr" SURFRAW_graphical=yes SURFRAW_lang="uk" sr google "${input}"

