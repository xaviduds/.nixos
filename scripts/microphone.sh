#!/bin/bash

volume_percentage=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $2}')
volume_state=$(amixer -M get Capture | awk -F'[\\[\\]]' 'END{print $4}')

# Directly outputting the result without explicit echo
( [ "$volume_state" == "off" ] && printf "%s%s\n" " " "$volume_percentage" || printf "%s%s\n" " " "$volume_percentage")
