#!/bin/bash
# install TWupdater
#
# @author: Alexandre Singh (https://github.com/DarthWound)
# @license: MIT license (MIT)

if [[ $EUID -ne 0 ]]; then
  echo "Ce script doit être lancé en tant que root" 1>&2
  exit 1
fi

clear

printf "Vérification des dépendances...\n"
sleep 2s
zypper refresh && zypper install libnotify-tools links lsb-release xdg-utils zenity

clear

printf "Installation des scripts...\n"
sleep 2s
cd /usr/bin/
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/scripts/french/snapshup-cli.sh
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/scripts/french/snapshup-gui.sh
chmod +x snapshup-cli.sh
chmod +x snapshup-gui.sh

clear

printf "Installation des services...\n"
sleep 2s
cd /usr/bin/
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/services/french/snapshek.sh
chmod +x snapshek.sh
cd /etc/xdg/autostart/
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/launchers/TWupdater.desktop
chmod +x TWupdater.desktop

clear

printf "Installation des lanceurs...\n"
sleep 2s
cd /usr/share/pixmaps/
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/images/twupic.png
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/images/twupic-cli.png
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/images/twupic-gui.png
cd /usr/share/applications/
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/launchers/TWupdater-CLI.desktop
wget https://raw.githubusercontent.com/DarthWound/tumbleweed-updater/master/launchers/TWupdater-GUI.desktop
chmod +x TWupdater-CLI.desktop
chmod +x TWupdater-GUI.desktop

clear

printf "Terminé !\n\n"
read -p "Appuyez sur ENTRÉE pour quitter."

exit 0
