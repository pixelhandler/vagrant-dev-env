#!/usr/bin/env bash

# jsctags - see git://github.com/mozilla/doctorjs.git
if [ -x jsctags ]; then
    echo 'jsctags is installed. '
else
	rm -fr /usr/local/src/doctorjs
    cd /usr/local/src && git clone git://github.com/mozilla/doctorjs.git
    cd doctorjs && git submodule update --init --recursive
    make install
fi