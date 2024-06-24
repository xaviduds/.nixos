#!/bin/bash

volume_percentage=$(amixer -M get Master | awk -F'[\\[\\]]' 'END{print $2}')
volume_state=$(amixer -M get Master | awk -F'[\\[\\]]' 'END{print $4}')
microphone_percentage=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $2}')
microphone_state=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $4}')

echo "Atenção é a fonte de amor, prazer e paz. Supere o que diminui isso."
printf "%s %s %s %s %s %s %s\n" \
"󰁹 $(cat /sys/class/power_supply/BAT0/capacity)%" \
" $(date +"%Y-%m-%d %H:%M:%S %A")" \
"$( [ "$volume_state" == "off" ] && printf "%s%s\n" "  " "$volume_percentage" || printf "%s%s\n" "  " "$volume_percentage")" \
"$( [ "$microphone_state" == "off" ] && printf "%s%s\n" " " "$microphone_percentage" || printf "%s%s\n" " " "$microphone_percentage")" \
"᠅ $(df --output=source,size,used,avail | awk -F " " 'END{printf "%.2f\n", $3/1024000}')GB" \
" $(free -t | awk -F " " 'END{printf "%.2f\n", ($4 - 16777212)/1024000}')GB" \
"| $(tmux list-windows -F '#{window_index}#{window_flags}' | awk '{gsub(/\*$/, "*"); printf "%s ", $0} END {print ""}')"
