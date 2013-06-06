#!/bin/bash
dialog --title "Configuring NFS virdir share" --infobox "Waiting for NFS mount..." 5 50

mkdir -p /virdir
chmod 777 /virdir

NETWORK_SEGMENT=`ifconfig eth0 | egrep 'inet addr' | cut -f3 -d'.'`
VIRDIR_GROUP=MY_SARA_VIRDIR
FSTAB_LINE="10.0.${NETWORK_SEGMENT}.4:/${VIRDIR_GROUP}	/virdir	nfs4	noauto,soft,bg	0	0"

echo $FSTAB_LINE >> /etc/fstab

# change the rc.local to default
sed -i 's_sh /root/firstboot.sh_exit 0_' /etc/rc.local

# return exit code 0 (all of above actions where successfull)
exit 0
