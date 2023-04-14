#!/bin/bash
set -e
shopt -s lastpipe
read -r input;
SURFRAW_graphical_browser="/snap/bin/firefox" SURFRAW_graphical=yes SURFRAW_lang="uk" sr google inurl:stackoverflow ${input}
