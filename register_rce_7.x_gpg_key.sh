#!/bin/bash

echo Downloading key...
# note: the same key is used for 6.x and 7.x releases
rm -f rce_6.x_signing_key.asc
wget -q https://raw.githubusercontent.com/rcenvironment/rce-signing/master/rce_6.x_signing_key.asc
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

gpg --import rce_6.x_signing_key.asc
# TODO add error code checking

echo 
echo If no error messages appeared above, the signature for RCE 7.x releases
echo has been successfully installed in your system. You can use this to verify
echo downloaded installation files using command-line tools\; please refer
echo to the RCE User Guide for details.
