#!/usr/bin/env bash

tmux list-windows -F '#{window_index}#{window_flags}' | awk '{gsub(/\*$/, "*"); printf "%s ", $0} END {print ""}'
