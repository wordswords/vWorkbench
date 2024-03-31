#!/bin/bash

set -x
set -e

speedtestver="1.2.0"
tmpdir=$(mktemp -d)
cd "${tmpdir}"
wget https://install.speedtest.net/app/cli/ookla-speedtest-${speedtestver}-linux-x86_64.tgz
tar xzf ookla-speedtest-*.tgz
mv "${tmpdir}"/speedtest ~/bin
rm -rf "${tmpdir}"

