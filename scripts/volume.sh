#!/bin/bash

amixer -M get Master | awk -F'[\\[\\]]' 'END{print $2}'
# echo "h"
# # volume_state=$(amixer -M get Master | awk -F'[\\[\\]]' 'END{print $4}')

# # Directly outputting the result without explicit echo
# # ( [ "$volume_state" == "off" ] && printf "%s%s\n" "  " "$volume_percentage" || printf "%s%s\n" "  " "$volume_percentage")
