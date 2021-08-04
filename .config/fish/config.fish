# Disable greeting message
set fish_greeting

# Only run path stuff if this is a login shell
if status --is-login
  # Reset our paths
  set --erase fish_user_paths

  prepend_path ~/documents/dotfiles/bin
  prepend_path ~/bin

  append_path ~/programs/android-sdk/tools
  append_path ~/programs/android-sdk/platform-tools
  append_path ~/programs/android-studio/bin
  append_path ~/programs/go/root/bin
  append_path ~/programs/go/tools/bin
  append_path ~/programs/go/path/bin
  append_path ~/programs/npm/bin

  switch $XDG_SESSION_TYPE
  case wayland
    set --export --global MOZ_ENABLE_WAYLAND 1
    set --export --global _JAVA_AWT_WM_NONREPARENTING 1
    set --export --global CLUTTER_BACKEND wayland
    set --export --global SDL_VIDEODRIVER wayland
    set --export --global QT_STYLE_OVERRIDE adwaita-dark
  case x11
    set --export --global DE generic
    set --export --global _JAVA_AWT_WM_NONREPARENTING 1
  end
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set --export --global PAGER less
  set --export --global EDITOR nvim
  set --export --global BROWSER firefox
  set --export --global MANPAGER "/bin/sh -c \"unset PAGER;unset MANPAGER;col -b -x | \
    nvim -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""

  export_dir ANDROID_HOME ~/programs/android-sdk
  export_dir GOROOT ~/programs/go/root
  export_dir GOPATH ~/programs/go/path

  setup_keychain
end
