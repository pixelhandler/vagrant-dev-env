#!/usr/bin/env bash

# {{{ Ubuntu utilities

<%= import 'vagrant-shell-scripts/ubuntu.sh' %>

# }}}

# Use Google Public DNS for resolving domain names.
# The default is host-only DNS which may not be installed.
nameservers-local-purge
nameservers-append '8.8.8.8'
nameservers-append '8.8.4.4'

# Use a local Ubuntu mirror, results in faster downloads.
apt-mirror-pick 'bg'

# Update packages cache.
apt-packages-update

# Install VM packages.
apt-packages-install     \
  git-core               \
  nodejs                 \
  npm                    \
  mongodb-10gen          \
  default-jdk            \
  imagemagick            \
  curl                   \
  ack-grep               \
  vim                    \
  build-essential        \
  chrpath                \
  libssl-dev             \
  libfontconfig          \
  libjpeg-progs          \
  optipng                \
  ruby                   \
  rubygems               \
  rake

<%= import 'init/lamp.sh' %>
<%= import 'init/yeoman.sh' %>

