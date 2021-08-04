#!/bin/sh

export CLUTTER_BACKEND=wayland
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORM=wayland-egl
export QT_STYLE_OVERRIDE=adwaita-dark
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

systemd-cat --identifier=sway sway $@

systemctl --user stop sway-session.target
