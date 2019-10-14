# Disable greeting message
set fish_greeting

# Only run path stuff if this is a login shell
if status --is-login
  # Reset our paths
  set --erase fish_user_paths

  prepend_path ~/code/scripts
  prepend_path ~/bin

  append_path ~/programs/android-sdk/tools
  append_path ~/programs/android-sdk/platform-tools
  append_path ~/programs/android-studio/bin
  append_path ~/programs/go/root/bin
  append_path ~/programs/go/tools/bin
  append_path ~/programs/go/path/bin
  append_path ~/programs/npm/bin
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set --export --global PAGER less
  set --export --global MANPAGER 'nvim -c "set ft=man" -'
  set --export --global EDITOR nvim
  set --export --global BROWSER firefox

  export_dir ANDROID_HOME ~/programs/android-sdk
  export_dir GOROOT ~/programs/go/root
  export_dir GOPATH ~/programs/go/path

  setup_keychain
end
