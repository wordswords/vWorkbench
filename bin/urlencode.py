#!/bin/python3

import urllib.parse;
with open('/tmp/googlesearchvim') as f:
    with open('/tmp/googlesearchvimencoded','w+') as d:
        contents = urllib.parse.quote(f.read());
        d.write(contents)
