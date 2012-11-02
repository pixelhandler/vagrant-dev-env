#!/usr/bin/env bash

# see https://github.com/rupa/z.git
if [ -x /usr/local/bin/z.sh ]; then
    echo 'z is installed. '
else
    cd /usr/local/src/ && git clone https://github.com/rupa/z.git
    cd z && git checkout v1.4
    cp z.sh /usr/local/bin/z.sh
    chmod u+x /usr/local/bin/z.sh
fi