#!/bin/bash
# update openSUSE Tumbleweed (GUI)
#
# @author: Alexandre Singh (https://github.com/DarthWound)
# @link: https://github.com/DarthWound/tumbleweed-updater
# @license: MIT license (MIT)

### VARIABLES

# AvailableTumbleweedSnapshot
readonly ATS=$(wget -qO - "http://download.opensuse.org/tumbleweed/repo/oss/media.1/products" | grep -oP " \K\d+")
# CurrentTumbleweedSnapshot
readonly CTS=$(lsb_release -sr)
# UpdatedPackagesChangelog
readonly UPC="https://download.opensuse.org/tumbleweed/iso/Changes.$ATS.txt"
# Main menu actions
readonly act1="Mettre à jour le système ($CTS -> $ATS)"
readonly act2="Voir le changelog du snapshot $ATS"
readonly act3="Consulter les changelogs des snapshots précédents"
readonly act4="Explorer le dépôt Github de cet outil"
# Other text
readonly txt1="Aucune mise à jour disponible.\n\n<i>(Snapshot actuel : $CTS)</i>"
readonly txt2="Snapshot \"$ATS\" disponible !\nMettre à jour le système ?\n\n<i>(Snapshot actuel : $CTS)</i>"
readonly txt3="Sélectionner une procédure :"
readonly txt4="Mise à jour en cours, veuillez patienter..."
readonly txt5="Mise à jour terminée !"
readonly txt6="Mise à jour terminée.\n\nRapport enregistré dans ~/.TWupdater.txt"
# Buttons
readonly btn1="Fermer"
readonly btn2="Oui"
readonly btn3="Non"
readonly btn4="Valider"
readonly btn5="Quitter"
readonly btn6="Mettre à jour"
readonly btn7="Revenir au menu"

### FUNCTIONS

doact1() {
  (
    while read -r i; do
      echo "# $i"; sleep 3s;
    done < <(/usr/bin/xdg-su -c 'zypper ref')
  ) | zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --progress --width=640 --height=60 --pulsate --auto-close --no-cancel
  sleep 2s
  $(/usr/bin/xdg-su -c 'zypper dup --no-confirm --force-resolution --auto-agree-with-licenses' | tee ~/.TWupdater.txt) | zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --progress --width=640 --height=60 --pulsate --auto-close --no-cancel --text="$txt4"
  zenity --notification --window-icon="info" --text="$txt5"
  zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --info --width=320 --height=240 --text="$txt6" --ok-label="$btn1"
  exit 0
}

doact2() {
  zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --text-info --width=640 --height=480 --ok-label="$btn7" --cancel-label="$btn8" \
    --html \
    --url=$UPC
    if [ $? = 0 ]; then
      doact1
    elif [ $? = 1 ]; then
      break
    fi
}

doact3() {
  xdg-open https://download.opensuse.org/tumbleweed/iso/ &
}

doact4() {
  xdg-open https://github.com/DarthWound/tumbleweed-updater-gui/ &
}

### MAIN
if [ "$ATS" == "$CTS" ]; then
  zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --info --width=320 --height=240 --text="$txt1" --ok-label="$btn1"
elif [ "$ATS" != "$CTS" ]; then
  zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --question --width=320 --height=240 --ok-label="$btn2" --cancel-label="$btn3" \
    --text "$txt2"
      if [ $? = 0 ]; then
        while true; do
          action=$(
            zenity --title="Tumbleweed Updater" --name="Tumbleweed Updater" --list --radiolist --width=640 --height=240 --ok-label="$btn4" --cancel-label="$btn5" \
              --text="$txt3" \
              --hide-header --column="" --column="" \
              1 "$act1" \
              2 "$act2" \
              3 "$act3" \
              4 "$act4"
          )
            if [ $? = 0 ]; then
              read _action
              case $action in
                $act1)
                  doact1
                ;;
                $act2)
                  doact2
                ;;
                $act3)
                  doact3
                ;;
                $act4)
                  doact4
                ;;
              esac
            elif [ $? = 1 ]; then
              break
              exit 0
            fi
        done
      else
        exit 0
      fi
fi

exit 0
