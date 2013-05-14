#!/bin/bash
unset DEBCONF_REDIR
unset DEBCONF_FRONTEND
unset DEBIAN_HAS_FRONTEND
unset DEBIAN_FRONTEND

dialog --title "Postinstall" --infobox "Installing tools specific for this node..." 5 50

apt-get update
apt-get -y install \
    build-essential \
    byobu \
    cmake \
    git-core \
    libboost-all-dev \
    pkg-config \
    python-dev \
    rsync \
    sshfs \
    xauth \
    vim \
    vlan \
    vnstat \
    python-pip >> /root/postinstall.log 2>&1

dialog --title "Postinstall" --infobox "Done installing, rebooting in a moment..." 5 50

# Run firstboot.sh by rc.local on first boot.
sed -i 's_exit 0_sh /root/firstboot.sh_' /etc/rc.local >> /root/postinstall.log  2>&1;

# return exit code 0 (all of above actions where successfull)
exit 0
