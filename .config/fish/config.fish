# Disable greeting message
set fish_greeting ""

function prepend-path -a path -d 'Append to PATH if directory exists'
  if [ -d $path ]
    set -x PATH $path $PATH
    return 0
  end
  return 1
end

function append-path -a path -d 'Prepend to PATH if directory exists'
  if [ -d $path ]
    set -x PATH $PATH $path
    return 0
  end
  return 1
end

function verify-agent-vars -d 'Check if ssh-agent is running'
  if [ -z "$SSH_AUTH_SOCK" ]
    return 1
  end

  if [ -z "$SSH_AGENT_PID" -a -z "$SSH_CLIENT" ]
    return 1
  end

  if [ -n "$SSH_AGENT_PID" -a ! -O /proc/"$SSH_AGENT_PID" ]
    return 1
  end

  if [ ! -S "$SSH_AUTH_SOCK" ]
    return 1
  end

  if [ ! -O "$SSH_AUTH_SOCK" ]
    return 1
  end

  # Load our universal variables as exported globals.
  for v in SSH_AUTH_SOCK SSH_AGENT_PID SSH_CLIENT
    if set -Uq $v
      set -gx $v $$v
    end
  end

  ssh-add -l > /dev/null > /dev/null ^&1

  if [ $status -eq 2 ]
    return 1
  end

  return 0
end

function setup-keychain -d 'Set up ssh-agent keychain'
  if verify-agent-vars
    return 0
  end

  # Otherwise, start it
  eval (ssh-agent -c | sed 's/setenv/set -U/')

  verify-agent-vars
end

# Only run path stuff if this is a login shell
if status --is-login
  # Include environment variables from /etc/profile
  env -i HOME=$HOME bash -l -c 'export -p' | sed -e "/PATH/s/'//g;/PATH/s/:/ /g;s/=/ /;s/^declare/set/" | source

  prepend-path ~/bin

  if prepend-path ~/prefix/bin
    set -x MANPATH ~/prefix/share/man:$MANPATH
    set -x INFOPATH ~/prefix/share/info:$INFOPATH
  end

  if append-path /opt/bin
    set -x MANPATH $MANPATH:/opt/man
    set -x INFOPATH $INFOPATH:/opt/info
  end

  if append-path ~/programs/android-sdk/tools; and append-path ~/programs/android-sdk/platform-tools
    set -x ANDROID_HOME ~/programs/android-sdk
  end

  if append-path ~/programs/android-ndk
    set -x ANDROID_NDK ~/programs/android-ndk
    set -x ANDROID_NDK_HOME $ANDROID_NDK
  end

  if append-path ~/programs/go/bin
    set -x GOROOT ~/programs/go
  end

  if append-path ~/programs/go-tools/bin
    set -x GOPATH ~/programs/go-tools
  end

  append-path ~/code/scripts
  append-path ~/programs/npm/bin
  append-path ~/programs/android-studio/bin
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set -x PAGER less
  set -x EDITOR vim
  set -x BROWSER chromium
  set -x CHROME_BIN chromium

  set -x JAVA_HOME /usr/lib/jvm/default

  # Base16 Shell color scheme
  eval sh "$HOME/documents/dotfiles/base16-shell/scripts/base16-solarized-dark.sh"

  setup-keychain
end
