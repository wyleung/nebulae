#!/bin/bash
unset DEBCONF_REDIR
unset DEBCONF_FRONTEND
unset DEBIAN_HAS_FRONTEND
unset DEBIAN_FRONTEND

dialog --title "Postinstall" --infobox "Installing tools specific for this node..." 5 50

apt-get update
apt-get -y install build-essential pkg-config python-dev rsync byobu xauth vlan vnstat libboost-all-dev cmake python-pip >> /root/postinstall.log 2>&1

dialog --title "Postinstall" --infobox "Done installing, rebooting in a moment..." 5 50
exit 0
