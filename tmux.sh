#!/bin/sh

mkdir -p ${TOOLCHAIN}/tools
VER="3.6a"
ARCH="linux-x86_64"
TMUX_RELEASE="https://github.com/tmux/tmux-builds/releases/download/v${VER}/tmux-${VER}-${ARCH}.tar.gz"
INSTALL_DIR="${TOOLCHAIN}/tools/"

wget ${TMUX_RELEASE} && tar -xzf tmux-${VER}-${ARCH}.tar.gz

mv tmux ${INSTALL_DIR} && rm -rf tmux-${VER}-${ARCH}.tar.gz
