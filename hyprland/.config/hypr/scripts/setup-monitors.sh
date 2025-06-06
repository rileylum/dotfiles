#!/bin/bash

# Detect monitor configuration between single Laptop eDP-1 and PC running dual monitors DP-1 and DP-2
# and make appropriate changes to hyprland and waybar configurations
# TODO: add support for external monitors with laptop

set -e

HYPR_DIR="$XDG_CONFIG_HOME/hypr"
WAYBAR_DIR="$XDG_CONFIG_HOME/waybar"

if command -v hyprctl >/dev/null 2>&1; then
  outputs=$(hyprctl monitors -j | grep '^    "name":' | head -n1 | sed -E 's/.*"name": *"(.*)",?/\1/')
else 
  echo "Unable to detect outputs"
fi

if echo $outputs | grep "eDP-1"; then
  ln -sf "$HYPR_DIR/configs/workspaces-laptop.conf" "$HYPR_DIR/configs/workspaces.conf"
elif echo $outputs | grep "DP-1" && echo $outsputs | grep "DP-2"; then
  ln -sf "$HYPR_DIR/configs/workspaces-pc.conf" "$HYPR_DIR/configs/workspaces.conf"
fi

hyprctl reload >/dev/null 2>&1 || true
