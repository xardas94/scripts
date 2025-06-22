#!/bin/sh
set -e

function usage {
cat <<EOF
usage: $(basename "$0") [-hpn]
OPTIONS:
  -p    previous desktop
  -n    next desktop
  -h    print this message

Required tools: xdotool
EOF
}

FIRST=0
LAST=$(($(xdotool get_num_desktops) - 1))

while getopts "hpn" options; do
  case "${options}" in
    h) usage; exit 0;;
    p) LIMIT=$FIRST; DIRECTION="-1";;
    n) LIMIT=$LAST; DIRECTION="1";;
    *) usage; exit 1;;
  esac
done
[ $OPTIND -eq 1 ] && usage && exit 1
shift $((OPTIND -1))

CURRENT=$(xdotool get_desktop)
[[ $CURRENT -ne $LIMIT ]] && xdotool set_desktop --relative -- $DIRECTION
