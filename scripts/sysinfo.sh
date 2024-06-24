#!/bin/bash

# Get the current volume percentage and state
volume_percentage=$(amixer -M get Master | awk -F'[\\[\\]]' 'END{print $2}')
volume_state=$(amixer -M get Master | awk -F'[\\[\\]]' 'END{print $4}')


microphone_percentage=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $2}')
microphone_state=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $4}')

# Print the date followed by the volume indicator and percentage on the same line
printf "%s %s %s %s\n" "$(date)" \
"$( [ "$volume_state" == "off" ] && printf "%s%s\n" "  " "$volume_percentage" || printf "%s%s\n" "  " "$volume_percentage")" \
"$( [ "$microphone_state" == "off" ] && printf "%s%s\n" " " "$microphone_percentage" || printf "%s%s\n" " " "$microphone_percentage")" \
"᠅ $(df -h --output=source,size,used,avail | awk -F " " 'END{print $3}')"
# wifi󰤨󰤮
# cpu
# ram
# bateria󰁹
