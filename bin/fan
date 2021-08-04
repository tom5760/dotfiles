#!/usr/bin/env fish
#
# Toggle fan speed

set FAN /proc/acpi/ibm/fan

function set_fan --argument-names level
  echo "level $level" | sudo tee $FAN
end

function get_fan
  grep 'level:' < $FAN | cut --fields 3
end

function toggle
  if test (get_fan) = "auto"
    set_fan full-speed
  else
    set_fan auto
  end
  get_fan
end

if test (count $argv) -lt 1
  toggle
else
  set_fan $argv[1]
end
