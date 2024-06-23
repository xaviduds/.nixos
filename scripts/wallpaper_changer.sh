#!/bin/bash

swww img "$(find "$HOME/.nixos/wallpapers" -type f -name "*.png" | shuf -n 1)"
