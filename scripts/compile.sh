#!/bin/bash

# query directory where this bash script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PWD=$(pwd)
CONF_DIR=$(dirname "${DIR}/../conf/lang")

echo "Please enter your password to run sudo"

sudo cp $CONF_DIR/txt.cfg $PWD/custom-iso/isolinux/
sudo cp $CONF_DIR/preseed.cfg $PWD/custom-iso/preseed/nebulae.seed
sudo cp $CONF_DIR/lang $PWD/custom-iso/isolinux/lang
sudo cp $CONF_DIR/isolinux.cfg $PWD/custom-iso/isolinux/

echo "Creating iso image from custom-iso"

sudo mkisofs -r -quiet \
-J -l -b isolinux/isolinux.bin \
-no-emul-boot \
-boot-load-size 4 -boot-info-table \
-z -iso-level 4 \
-c isolinux/isolinux.cat \
-o $PWD/custom-ubuntu.iso $PWD/custom-iso/
echo "Image is ready to use"
