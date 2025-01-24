#!/bin/bash

allargs="$@"
query="search: ${allargs}"
tod task next -f "${query}"
tod task complete

