#!/bin/bash

KEY_EXPORT_FILE_NAME=rce_9.x_signing_key.asc

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
gpg --with-fingerprint "${KEY_EXPORT_FILE_NAME}" | grep fingerprint

while true; do
    read -p "Proceed [y/n]? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer with 'y' or 'n'";;
    esac
done

gpg --import "${KEY_EXPORT_FILE_NAME}"
# TODO add error code checking

echo 
echo If no error messages appeared above, the signature for RCE 8.x and 9.x releases
echo has been successfully installed in your system. You can use this to verify
echo downloaded installation files using command-line tools\; please refer
echo to the RCE User Guide for details.
