#!/bin/sh

mkdir -p ${TOOLCHAIN}/tools
setenv CARGO_HOME ${TOOLCHAIN}/tools/rust/cargo
setenv RUSTUP_HOME ${TOOLCHAIN/tools/rust/rustup

mkdir -p ${TOOLCHAIN}/tools/rust || exit

# don't allow install script to add paths to PATH, do it manually :)
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

setenv PATH ${PATH}:${TOOLCHAIN}/tools/rust/cargo/bin

cargo install fd-find
cargo install ripgrep
cargo install alacritty
