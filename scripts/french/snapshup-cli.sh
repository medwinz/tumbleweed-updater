#!/bin/bash
# update openSUSE Tumbleweed (CLI)
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
readonly act5="Quitter"
# Other text
readonly txt1="\n\n  Aucune mise à jour disponible.\n  (Snapshot actuel : $CTS)\n\n"
readonly txt2="\n\n  Snapshot \"$ATS\" disponible !\n  (Snapshot actuel : $CTS)\n\n"
readonly txt3="SÉLECTIONNER UNE PROCÉDURE ET VALIDER :"
readonly txt4="Mise à jour terminée !"
readonly txt5="Mise à jour terminée.\nRapport enregistré dans ~/.TWupdater.txt\n\n"
readonly txt6="Appuyez sur ENTRÉE pour quitter."
readonly txt7="Appuyez sur ENTRÉE pour défiler - Appuyez sur Q pour fermer"
readonly txt8="\n (appuyez sur Q pour fermer une fois terminé)"
readonly txt9="Cette option n'existe pas."

### FUNCTIONS

doact1() {
  #su -c 'zypper ref && screen -q zypper --color dup' | tee ~/.TWupdater.txt
  su -c 'zypper ref && zypper --color dup' | tee ~/.TWupdater.txt
  notify-send -i info "$txt4"
  clear
  printf "$txt5"
  read -p "$txt6"
}

doact2() {
  wget -qO - /tmp/Changes.$ATS.txt $UPC | less --prompt="M$txt7"
}

doact3() {
  printf "$txt8"
  sleep 3s
  links https://download.opensuse.org/tumbleweed/iso/
}

doact4() {
  printf "$txt8"
  sleep 3s
  links https://github.com/DarthWound/tumbleweed-updater/
}

### MAIN

clear
while [ 1 ];do
  clear
  printf "\n  \e[7mTumbleweed Updater\e[0m\n"

if [ "$ATS" == "$CTS" ]; then
  printf "$txt1"
elif [ "$ATS" != "$CTS" ]; then
  printf "$txt2"
fi

  printf "
    1 -> $act1
    2 -> $act2
    3 -> $act3
    4 -> $act4
    5 -> $act5
    \n"
  printf "\n  $txt3 "
  read _action
    case $_action in
      1)
        clear
        doact1
        sleep 2s
      ;;
      2)
        clear
        doact2
        sleep 2s
      ;;
      3)
        clear
        doact3
        sleep 2s
      ;;
      4)
        clear
        doact4
        sleep 2s
      ;;
      5)
        clear
        break
      ;;
      *)
        clear
        printf "\e[1m$txt9\e[0m"
        sleep 2s
      ;;
    esac
done

exit 0
