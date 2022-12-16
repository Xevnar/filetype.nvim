#!/usr/bin/sh

cp -vr ./lua ./filetype.lua ./neovim/runtime
cd neovim
TEST_FILE='test/functional/lua/filetype_spec.lua'  make functionaltest
