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
  chrpath                \
  inotify-tools          \
  build-essential        \
  openssl                \
  automake               \
  autoconf               \
  libtool                \
  subversion             \
  pkg-config             \
  bison                  \
  libreadline6           \
  libreadline6-dev       \
  zlib1g                 \
  zlib1g-dev             \
  libssl-dev             \
  libyaml-dev            \
  libsqlite3-dev         \
  sqlite3                \
  libxml2-dev            \
  libxslt-dev            \
  libc6-dev              \
  ncurses-dev  

dpkg-divert --local --divert /usr/bin/ack --rename --add /usr/bin/ack-grep

<%= import 'bin/ruby.sh' %>
<%= import 'bin/node.sh' %>
<%= import 'bin/mongo.sh' %>
<%= import 'bin/lamp.sh' %>
<%= import 'bin/yeoman.sh' %>
<%= import 'bin/vim-config.sh' %>
<%= import 'bin/z-config.sh' %>
<%= import 'bin/jsctags.sh' %>
<%= import 'bin/dotfiles.sh' %>

echo 'if [ -d "/vagrant/bin" ]; then PATH=$PATH":/vagrant/bin"; fi' >> ~/.profile


