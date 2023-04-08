#!/usr/bin/sh
# Script to build neovim in the current directory

# This is the latest synced up commit, update as it goes
NEOVIM_COMMIT='e30cc8be1950a6d1dec7395807966e1b5d0d9194'

# Shallow Fetch neovim
mkdir neovim && cd neovim
git init
git remote add origin 'https://github.com/neovim/neovim.git'
git fetch --depth 1 --progress origin "$NEOVIM_COMMIT"
git checkout FETCH_HEAD

# Build neovim
make
