#!/bin/bash
set -e

max_opacity=4294967295 #0xffffffff

function usage {
cat <<EOF
usage: $(basename "$0") -d value|-i value|-s value
OPTIONS:
  -d value  decrease current opacity level by number
  -i value  increase current opacity level by number
  -s value
            set opacity to value

Required tools: xdotool, xprop
EOF
}

function get_active_win_id {
  printf '0x%x\n' $(xdotool getactivewindow)
}

function get_opacity {
  local opacity=$(xprop -id $1 _NET_WM_WINDOW_OPACITY | grep -o '[[:digit:]]*')
  [[ -z "${opacity}" ]] && return
  echo $opacity
}

function set_opacity {
  local opacity=$2
  echo "local opacity=$opacity"
  if ((opacity < 0)); then 
    opacity=0
  elif ((opacity > max_opacity)); then 
    opacity=$max_opacity;
  fi
  echo "local opacity=$opacity"
  xprop -id $1 -f _NET_WM_WINDOW_OPACITY 32c -set _NET_WM_WINDOW_OPACITY $opacity
}

while getopts "d:i:s:" options; do
  case "${options}" in
    h) usage; exit 0;;    
    d) new_opacity=$((-1 * max_opacity * OPTARG / 100));;
    i) new_opacity=$((max_opacity * OPTARG / 100));;
    s) set_opacity $(get_active_win_id) $((max_opacity * OPTARG / 100)) && exit 0;;
    :) echo "Error: -${OPTARG} requires an argument.";&
    *) usage; exit 1;;
  esac
done
shift $((OPTIND -1))

active_win=$(get_active_win_id)
opacity=$(get_opacity $active_win)
echo "$opacity"
echo "$new_opacity"

if [ -z "${opacity}" ]; then
  #_NET_WM_WINDOW_OPACITY property is not set, set it to 100%
  opacity=$max_opacity
  set_opacity $active_win $opacity
fi

opacity=$((opacity + new_opacity))
set_opacity $active_win $opacity
