#!/bin/bash -e

source functions.sh

# Prerequisites
install_if_needed build-essential
install_if_needed cmake
install_if_needed python-dev
install_if_needed python3-dev

# this will nuke the current config
# be careful!
./cleanup.sh

# now remake the directory
mkdir ~/.vim

# install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# copy the vimrc file
cp vimrc ~/.vim/vimrc

# do the plugin installation within vim.
# note that YCM takes a long time to download
vim +PluginInstall +qall

cd ~/.vim/bundle/YouCompleteMe
# check if we need to compile the ycm_core library
if [ ! -f 'third_party/ycmd/ycm_core.so' ]; then
    ./install.py --clang-completer
fi

# next install default autocompletion file

# then set up airline
