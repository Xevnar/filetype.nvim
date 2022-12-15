#!/usr/bin/sh
# Script to build neovim in the current directory

git clone --branch master --single-branch https://github.com/neovim/neovim.git --depth 1
cd neovim
make
