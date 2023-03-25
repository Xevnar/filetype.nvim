#!/usr/bin/sh
# Script to build neovim in the current directory

# This is the latest synced up commit, update as it goes
NEOVIM_COMMIT='ee5008f8789f61a3b153220abb870dd49427e52c'

# Shallow Fetch neovim
mkdir neovim && cd neovim
git init
git remote add origin 'https://github.com/neovim/neovim.git'
git fetch --depth 1 --progress origin "$NEOVIM_COMMIT"
git checkout FETCH_HEAD

# Build neovim
make
