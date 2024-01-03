#!/bin/python3
import sys
import urllib.parse;
with open(sys.argv[1]) as f:
    with open('/tmp/googlesearchencoded','w+') as d:
        contents = urllib.parse.quote(f.read());
        d.write(contents)
