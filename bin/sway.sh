#!/bin/sh

export CLUTTER_BACKEND=wayland
export ECORE_EVAS_ENGINE=wayland-egl
export ELM_ENGINE=wayland_egl
export _JAVA_AWT_WM_NONREPARENTING=1
export MOZ_DBUS_REMOTE=1
export MOZ_ENABLE_WAYLAND=1
export NO_AT_BRIDGE=1
export QT_QPA_PLATFORM=wayland-egl
export SDL_VIDEODRIVER=wayland
export XDG_CURRENT_DESKTOP=sway
export XDG_SESSION_DESKTOP=sway
export XDG_SESSION_TYPE=wayland

export QT_STYLE_OVERRIDE=adwaita-dark

# https://github.com/swaywm/wlroots/blob/master/docs/env_vars.md#drm-backend
export WLR_DRM_NO_MODIFIERS=1

systemd-cat --identifier=sway sway $@

systemctl --user stop sway-session.target
