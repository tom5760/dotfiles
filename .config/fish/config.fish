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
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set --export --global PAGER less
  set --export --global EDITOR nvim
  set --export --global BROWSER firefox
  set --export --global MANPAGER "/bin/sh -c \" \
    unset PAGER; \
    unset MANPAGER; \
    col --no-backspace --spaces | \
    nvim -R \
      -c 'set ft=man nomod nolist' \
      -c 'map q :q<CR>' \
      -c 'map <SPACE> <C-D>' \
      -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' \
      -\""

  set --export --global XDG_DATA_DIRS "$HOME/.local/share/flatpak/exports/share:$XDG_DATA_DIRS"

  export_dir GOROOT ~/programs/go/root
  export_dir GOPATH ~/programs/go/path

  setup_keychain
end
