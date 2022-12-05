#!/usr/bin/sh
# Script to build neovim in the current directory

git clone https://github.com/neovim/neovim.git
rm -vf neovim/runtime/filetype.lua
cd neovim
make > /dev/null 2>&1
