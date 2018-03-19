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
readonly act1="Run system update ($CTS -> $ATS)"
readonly act2="Read snapshot $ATS changelog"
readonly act3="See previous snapshots changelogs"
readonly act4="Explore Github repository of this tool"
# Other text
readonly txt1="No updates available.\n\n<i>(Current snapshot: $CTS)</i>"
readonly txt2="Snapshot \"$ATS\" available!\nRun system update?\n\n<i>(Current snapshot: $CTS)</i>"
readonly txt3="Select an option:"
readonly txt4="Updating, please wait..."
readonly txt5="Update done!"
readonly txt6="Update done.\n\nLog saved in ~/.TWupdater.txt"
# Buttons
readonly btn1="Close"
readonly btn2="Yes"
readonly btn3="No"
readonly btn4="Confirm"
readonly btn5="Quit"
readonly btn6="Update"
readonly btn7="Back"

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
  xdg-open https://github.com/DarthWound/tumbleweed-updater/ &
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
