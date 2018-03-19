#!/bin/bash
# check updates for openSUSE Tumbleweed
#
# @author: Alexandre Singh (https://github.com/DarthWound)
# @license: MIT license (MIT)

# AvailableTumbleweedSnapshot
readonly ATS=$(wget -qO - "http://download.opensuse.org/tumbleweed/repo/oss/media.1/products" | grep -oP " \K\d+")
# CurrentTumbleweedSnapshot
readonly CTS=$(lsb_release -sr)
# Message
readonly txt0="Snapshot \"$ATS\" disponible !"

while true ; do
  if [ "$ATS" != "$CTS" ]; then
    notify-send -i info "$txt0"
  fi
  sleep 45m
done

exit 0
