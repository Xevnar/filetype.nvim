#!/usr/bin/sh

cp -vr ./lua ./filetype.lua ./neovim/runtime
cd neovim
TEST_FILE="test/functional/autocmd/filetype_spec.lua" make functionaltest
