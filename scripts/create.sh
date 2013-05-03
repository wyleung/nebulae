#!/bin/bash

# query directory where this bash script is stored
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PWD=$(pwd)


usage()
{
cat << EOF
usage: $0 options

OPTIONS:
   -h      Show this message
   -i      Input ISO file
   -v      Verbose
EOF
}

INPUT_ISO=
while getopts "hi:v" OPTION
do
     case $OPTION in
         h)
             usage
             exit 1
             ;;
         i)
             INPUT_ISO=$OPTARG
             ;;
         ?)
             usage
             exit
             ;;
     esac
done

if [ -z $INPUT_ISO ]
then
     usage
     exit 1
fi


# inspired by http://razvangavril.com/linux-administration/custom-ubuntu-server-iso/


mkdir -p original-iso custom-iso
sudo mount -o loop $INPUT_ISO ./original-iso

sudo cp -r ./original-iso/* ./custom-iso/
sudo cp -r ./original-iso/.disk/ ./custom-iso/

sudo umount ./original-iso/

sh $DIR/compile.sh

