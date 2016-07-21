#!/bin/bash -e

install_if_needed() {
    PKG_OK=$(dpkg-query -W --showformat='${Status}\n' ${1} | grep "install ok installed")
    echo "Checking for ${1}: ${PKG_OK}"
    if [ "" == "${PKG_OK}" ]; then
        echo "No ${1}. Setting up ${1}."
        sudo apt-get --force-yes --yes install ${1}
    fi
}

