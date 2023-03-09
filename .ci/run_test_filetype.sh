#!/usr/bin/sh

# Copy the repo to neovim overrwiting it's defaults
cp -vr ./lua ./filetype.lua ./neovim/runtime

# The location of the old test file
TEST_FILE='neovim/test/old/testdir/test_filetype.vim'

# Delete test from `Test_sig_file` that we don't care about
sed -i -E -e '1859d' "$TEST_FILE"

# Delete the `Test_conf_file` test.
sed -i -E -e '15,27d' "$TEST_FILE"

# Delet bash test from `Test_filetype_detection`
sed -i -E -e "s/'\.bashrc', 'file\.bash', //g" "$TEST_FILE"

# Delete shebang tests that we don't care about passing from `Test_script_detection`
sed -i -E -e '\%.*#!/path/(bash|dash|ksh).*%d' -e "s%\[\['#!/path/sh'],%[['#!/path/sh']],%g" "$TEST_FILE"

cd neovim
TEST_FILE='test_filetype.vim' make oldtest
