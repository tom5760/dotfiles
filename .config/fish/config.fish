# Disable greeting message
set fish_greeting

# Only run path stuff if this is a login shell
if status --is-login
  # Reset our paths
  set --erase fish_user_paths

  fish_add_path --prepend ~/documents/dotfiles/bin
  fish_add_path --prepend ~/bin

  fish_add_path --append ~/programs/go/root/bin
  fish_add_path --append ~/programs/go/path/bin
  fish_add_path --append ~/programs/npm/bin
  fish_add_path --append ~/programs/google-cloud-sdk/bin
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set --export --global PAGER less
  set --export --global EDITOR nvim
  set --export --global BROWSER firefox

  set --export --global MANWIDTH 999
  set --export --global MANPAGER "nvim -c 'Man!' -o -"

  set --export --global XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"

  set --export --global DEBUGINFOD_URLS "https://debuginfod.archlinux.org/"

  export_dir GOROOT ~/programs/go/root
  export_dir GOPATH ~/programs/go/path

  if [ -S ~/.1password/agent.sock ]
    set --export --universal SSH_AUTH_SOCK ~/.1password/agent.sock
  else
    setup_keychain
  end
end
