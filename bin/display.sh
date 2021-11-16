#!/bin/sh

display_home() {
  swaymsg 'output "eDP-1" pos 0 0,output "DP-2" pos 1920 0'
}

display_work() {
  swaymsg 'output "Dell Inc. DELL U2719D 1MV0KS2" pos 0 0,output "Dell Inc. DELL U2717D 67YGV8A6834S" pos 2560 0,output "eDP-1" pos 1280 1440'
}

main() {
  cmd=$1; shift

  "display_$cmd" "$@"
}

main "$@"
