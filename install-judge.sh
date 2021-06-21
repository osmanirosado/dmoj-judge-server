#!/bin/bash

set -x

mkdir /judge /problems && cd /judge || exit 1
curl -L https://github.com/DMOJ/judge-server/archive/master.tar.gz | tar -xz --strip-components=1
pip3 install -e .
sed -i 's/source "$HOME/. "\/home\/judge/' ~judge/.profile
source ~judge/.profile
runuser -u judge -w PATH -- dmoj-autoconf -V > /judge-runtime-paths.yml
echo '  crt_x86_in_lib32: true' >> /judge-runtime-paths.yml
