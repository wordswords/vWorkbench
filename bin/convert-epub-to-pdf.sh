#!/bin/bash

pandoc -f epub -t pdf "$1" --pdf-engine=xelatex -o "$1".pdf
