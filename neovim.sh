#!/bin/sh

mkdir -p ${TOOLCHAIN}/tools

NVIM_RELEASE=https://github.com/neovim/neovim/archive/refs/tags
VER=0.12.2
INSTALL_DIR="${TOOLCHAIN}/tools/neovim"
wget ${NVIM_RELEASE}/v${VER}.tar.gz && tar -xzf v${VER}.tar.gz
cd neovim-${VER} || exit

make CMAKE_EXTRA_FLAGS="-DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}" CMAKE_BUILD_TYPE=Release
make install

cd ../
rm -rf v${VER}.tar.gz neovim-${VER}
