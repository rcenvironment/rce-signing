#!/bin/bash

KEY_EXPORT_FILE_NAME=rce_7.x_signing_key.asc

echo Downloading key...
rm -f "${KEY_EXPORT_FILE_NAME}"
wget -q "https://raw.githubusercontent.com/rcenvironment/rce-signing/master/${KEY_EXPORT_FILE_NAME}"
# TODO add error code checking
echo Done.
echo
echo The sequence of numbers and letters below is the so-called \"fingerprint\" 
echo of the signature used to verify RCE releases before installing them. You 
echo should compare it against the RCE team\'s announcements, and only proceed
echo if it matches.
gpg --with-fingerprint rce_6.x_signing_key.asc | grep fingerprint

while true; do
    read -p "Proceed [y/n]? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer with 'y' or 'n'";;
    esac
done

apt-key adv --import "${KEY_EXPORT_FILE_NAME}"
echo Installing the RCE repository into the package management\'s list of sources
rm -f /etc/apt/sources.list.d/dlr_rce_7_releases.list
rm -f /etc/apt/sources.list.d/dlr_rce_7_snapshots.list
# TODO query for this choice
#echo "deb http://software.dlr.de/updates/rce/7.x/products/standard/snapshots/trunk/deb/ /" >/etc/apt/sources.list.d/dlr_rce_7_snapshots.list
echo "deb http://software.dlr.de/updates/rce/7.x/products/standard/releases/latest/deb/ /" >/etc/apt/sources.list.d/dlr_rce_7_releases.list

# TODO add error code checking
echo 
echo If no error messages appeared above, the signature and download locations
echo for RCE 7.x have been successfully installed in your system. You can use 
echo the standard tools of your operating system to install and update the 
echo \"rce\" software package. You will also receive automatic notifications
echo on updates.
echo

while true; do
    read -p "Would you like to install RCE automatically now [y/n]? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer with 'y' or 'n'";;
    esac
done

echo Updating software repositories...
apt-get update
echo Installing RCE
apt-get install rce
