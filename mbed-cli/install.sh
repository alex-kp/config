#!/bin/bash
#
# Installs mbed-cli and GCC ARM tools
#

# get the directory in which this script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# go to the directory containing this script
cd ${DIR}
# This gives the install_if_needed utility function
source ../util/functions.sh
# Get the version of the GCC ARM tools to use
source gcc_version

# Script config
MBED_PROJECTS_DIR=~/mbed    # Dir to store mbed projects
#MBED_PROJECTS_DIR=/media/sf_mbed    # Dir to store mbed projects
GDB_REMOTE_SERVER="192.168.99.1:3333"  # Address of gdb remote server for debugging

# Prerequisites
install_if_needed cu        # Serial terminal
install_if_needed python
install_if_needed python-pip
sudo -H pip install --upgrade pip
install_if_needed git
install_if_needed mercurial
install_if_needed curl

# These are for the 32 bit GCC ARM tools
install_if_needed lib32z1
install_if_needed lib32ncurses5
install_if_needed libbz2-1.0:i386

pushd .  # Save directory
# Install virtualenv
sudo -H pip install virtualenv
# Make a directory for all mbed projects
mkdir ${MBED_PROJECTS_DIR}; cd ${MBED_PROJECTS_DIR}
# Create and activate the virtual python environment
echo "Directory for projects is: `pwd`"
virtualenv env
source env/bin/activate
popd    # Restore directory

# Install mbed-cli from pip
pip install mbed-cli
# Install requirements for mbed-cli
pip install -r requirements.txt
# Install pyOCD for debugging CMSIS-DAP device
pip install --pre -U pyocd
# Set udev rules so that non-root user can debug
# *** not yet working so commented out ***
# *** would also need matching uninstall in remove.sh ***
#
#sudo bash -c 'cat > /etc/udev/rules.d/mbed.rules << EOF
#SUBSYSTEM=="usb", ATTR{idVendor}=="0d28", ATTR{idProduct}=="0204", MODE:="666"
#EOF'
#


# Check if GCC ARM tools are installed. The GCC_ARM* variables are defined in
# the file 'gcc_version'
if [ ! -d "${GCC_ARM_PREFIX}/${GCC_ARM}" ]; then
    # Check if the file is downloaded already
    if [ ! -f ${GCC_ARM}${GCC_ARM_EXT} ]; then
        # Download the file from launchpad
        echo "No ${GCC_ARM}. Setting up ${GCC_ARM}."
        curl -LO ${GCC_ARM_BASE_URL}${GCC_ARM}${GCC_ARM_EXT}
    fi
    # Unpack the tools
    tar xf ${GCC_ARM}${GCC_ARM_EXT}
    # Copy to install location
    sudo cp -R ${GCC_ARM} ${GCC_ARM_PREFIX}
fi

# Set up mbed tools to use the compiler at the new path
mbed config --global GCC_ARM_PATH "${GCC_ARM_PREFIX}/${GCC_ARM}/bin"

# Create a gdbinit file template for use in projects
cat <<EOF > ${MBED_PROJECTS_DIR}/gdbinit
target remote ${GDB_REMOTE_SERVER}
load
monitor reset
break main
EOF


