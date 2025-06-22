#!/bin/sh
#set -x
set -e

function get_active_win_id {
  printf '0x%x\n' $(xdotool getactivewindow)
}

function is_decorated {
  xprop -id $1 _MOTIF_WM_HINTS | cut -d',' -f3 | cut -d' ' -f2
}

function set_decoration {
  xprop -id $1 -f _MOTIF_WM_HINTS 32c -set _MOTIF_WM_HINTS "0x2, 0x0, 0x$2, 0x0, 0x0"
}

curr_win_id=$(get_active_win_id)
decoration=$(is_decorated $curr_win_id)

[ $decoration -eq 1 ] && set_decoration $curr_win_id 0\
|| [ -z $decoration ] && set_decoration $curr_win_id 0\
|| set_decoration $curr_win_id 1
