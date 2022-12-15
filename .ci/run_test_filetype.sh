#!/usr/bin/sh

cp -vr ./lua ./filetype.lua ./neovim/runtime

# Only leave test_file_detection
sed -i -E -e '697,2010d' neovim/src/nvim/testdir/test_filetype.vim
sed -i -E -e '51,118d' neovim/src/nvim/testdir/test_filetype.vim
sed -i -E -e '2,44d' neovim/src/nvim/testdir/test_filetype.vim
sed -i -E -e '251,548d' neovim/src/nvim/testdir/test_filetype.vim
sed -i -E -e '5,243d' neovim/src/nvim/testdir/test_filetype.vim

cd neovim
TEST_FILE='test_filetype.vim' make oldtest
