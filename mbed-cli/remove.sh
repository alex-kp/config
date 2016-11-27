#!/bin/bash

# get the directory in which this script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# go to the directory containing this script
cd ${DIR}
# get the gcc version that was used
source gcc_version

# First remove the python virtualenv inside the mbed dir, which gets rid of
# the mbed tools
rm -rf ~/mbed/env

# Remove the gcc tools from /usr/local
#   be careful with this rm -rf line if editing
sudo rm -rf /usr/local/${GCC_ARM}

