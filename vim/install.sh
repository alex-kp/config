#!/bin/bash -e

VIM_CONF_DIR=~/.vim

source functions.sh

# Prerequisites
install_if_needed build-essential
install_if_needed cmake
install_if_needed python-dev
install_if_needed python3-dev

# this will nuke the current config
# be careful!
#./cleanup.sh

# remake the vim config directory if needed
[ -d ${VIM_CONF_DIR} ] ||  mkdir ${VIM_CONF_DIR}

# download Vundle is it's not already there
VUNDLE_PATH=${VIM_CONF_DIR}/bundle/Vundle.vim
[ -d ${VUNDLE_PATH} ] || \
    git clone https://github.com/VundleVim/Vundle.vim.git ${VUNDLE_PATH}

# copy the vimrc file
cp vimrc ${VIM_CONF_DIR}/vimrc

# do the plugin installation within vim.
# note that YCM takes a long time to download
vim +PluginInstall +qall

pushd .
cd ~/.vim/bundle/YouCompleteMe
# check if we need to compile the ycm_core library
[ -f 'third_party/ycmd/ycm_core.so' ] || ./install.py --clang-completer
popd

# next install default autocompletion file

# then set up airline
