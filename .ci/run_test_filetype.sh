#!/usr/bin/sh

cp -vr ./lua ./filetype.lua ./neovim/runtime
cd neovim
make oldtest TEST_FILE=test_filetype.vim
