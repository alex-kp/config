#!/bin/bash

# get the directory in which this script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# go to the directory containing this script
cd ${DIR}
# This gives the install_if_needed utility function
source ../util/functions.sh

# Prerequisites
install_if_needed "build-essential"
install_if_needed "cmake"
install_if_needed "libusb-1.0"
install_if_needed "libusb-1.0.0-dev"
install_if_needed "libgtk-3-dev"

git clone https://github.com/texane/stlink.git
cd stlink
mkdir build
cd build

cmake -DCMAKE_BUILD_TYPE=Debug ..
make
sudo make install

