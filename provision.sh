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
apt-mirror-pick 'us'

# Update packages cache.
apt-packages-update

# Install VM packages.
apt-packages-install     \
  git-core               \
  default-jdk            \
  imagemagick            \
  curl                   \
  ack-grep               \
  vim                    \
  build-essential        \
  chrpath

dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

<%= import 'vagrant-shell-scripts/bin/ruby.sh' %>
<%= import 'vagrant-shell-scripts/bin/node.sh' %>
<%= import 'vagrant-shell-scripts/bin/mongo.sh' %>
<%= import 'vagrant-shell-scripts/bin/lamp.sh' %>
<%= import 'vagrant-shell-scripts/bin/yeoman.sh' %>

