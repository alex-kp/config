#!/bin/bash

# set the directory where all the vim config files go
VIM_CONF_DIR=~/.vim
POWERLINE_FONTS_REPO=https://github.com/powerline/fonts.git
POWERLINE_FONTS_DIR=~/.local/share/fonts

# get the directory in which this script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# go to the directory containing this script
cd ${DIR}

# This gives the install_if_needed utility function
source ../util/functions.sh

# Prerequisites
#install_if_needed vim-athena       # minimal dependencies
install_if_needed vim-gtk          # no gnome dependencies
#install_if_needed vim-gnome        # with gnome dependencies
install_if_needed build-essential
install_if_needed cmake
install_if_needed python-dev
install_if_needed python3-dev

if [ ! -d "${POWERLINE_FONTS_DIR}" ]; then
    [ -d "fonts" ] || git clone ${POWERLINE_FONTS_REPO}
    cd fonts
    ./install.sh
    cd ..
    echo "installed powerline fonts"
fi

# this will nuke the current config
# be careful!
#./cleanup.sh

# remake the vim config directory if needed
[ -d ${VIM_CONF_DIR} ] ||  mkdir ${VIM_CONF_DIR}

# download Vundle if it's not already there
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
cp ycm_extra_conf.py ${VIM_CONF_DIR}

