#!/usr/bin/env bash

tmux list-windows -F '#{window_index}:#{window_name}#{window_flags} ' | awk '{gsub(/\*$/, "*"); printf "%s ", $0} END {print ""}' | sed 's/|/ | /g'
