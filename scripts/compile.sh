#!/bin/bash

# query directory where this bash script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PWD=$(pwd)
CONF_DIR=$(dirname "${DIR}/../conf/lang")


usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h      Show this message
   -s      SARA virdir account
   -v      Verbose
EOF
}

SARA_VIRDIR=
while getopts "hs:v" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         s)
             SARA_VIRDIR=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [ -z $SARA_VIRDIR ]
then
     usage
     exit 1
fi


sudo cp $CONF_DIR/txt.cfg $PWD/custom-iso/isolinux/
sudo cp $CONF_DIR/preseed.cfg $PWD/custom-iso/preseed/nebulae.seed
sudo cp $CONF_DIR/lang $PWD/custom-iso/isolinux/lang
sudo cp $CONF_DIR/isolinux.cfg $PWD/custom-iso/isolinux/
sudo cp $CONF_DIR/postinstall.sh $PWD/custom-iso/install/

sudo cp $CONF_DIR/firstboot.sh $PWD/custom-iso/install/

# change SARA virdir groupname in firstboot.sh
sudo sed -i 's/MY_SARA_VIRDIR/'$SARA_VIRDIR'/' $PWD/custom-iso/install/firstboot.sh

echo "Creating iso image from custom-iso"

sudo mkisofs -r -quiet \
    -J -l -b isolinux/isolinux.bin \
    -no-emul-boot \
    -boot-load-size 4 \
    -boot-info-table \
    -z -iso-level 4 \
    -c isolinux/isolinux.cat \
    -o $PWD/custom-ubuntu.iso $PWD/custom-iso/
echo "Image is ready to use"
