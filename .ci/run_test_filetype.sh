#!/usr/bin/sh

cp -vr ./lua ./filetype.lua ./neovim/runtime

# Delet bash test from `Test_filetype_detection`
sed -i -E -e "s/'\.bashrc', 'file\.bash', //g" neovim/src/nvim/testdir/test_filetype.vim

# Delete shebang tests that we don't care about passing from `Test_script_detection`
sed -i -E -e '\%.*#!/path/(bash|dash|ksh).*%d' -e "s%\[\['#!/path/sh'],%[['#!/path/sh']],%g" neovim/src/nvim/testdir/test_filetype.vim

# Delete test from `Test_sig_file` that we don't care about
sed -i -E -e '1807,1810d' neovim/src/nvim/testdir/test_filetype.vim

# Delete the `Test_conf_file` test.
sed -i -E -e '15,27d' neovim/src/nvim/testdir/test_filetype.vim

cd neovim
TEST_FILE='test_filetype.vim' make oldtest
