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

  ssh-add -l > /dev/null > /dev/null ^&1

  if [ $status -eq 2 ]
    return 1
  end

  return 0
end

function load-agent-keys -d 'Load ssh-agent default keys'
  ssh-add
  ssh-add ~/.ssh/id_rsa_lifeshield
  ssh-add ~/.ssh/id_dsa_lsdev
end

function setup-keychain -d 'Set up ssh-agent keychain'
  if verify-agent-vars
    return 0
  end

  # Otherwise, start it
  eval (ssh-agent -c | sed 's/setenv/set -Ux/')

  verify-agent-vars
end

# Only run path stuff if this is a login shell
if status --is-login
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
    set -x $ANDROID_HOME ~/programs/android-sdk
  end

  if append-path ~/programs/android-ndk
    set -x ANDROID_NDK ~/programs/android-ndk
    set -x ANDROID_NDK_HOME $ANDROID_NDK
  end

  if append-path ~/programs/go/bin
    set -x GOPATH ~/programs/go
  end

  append-path ~/programs/npm/bin
  append-path ~/code/scripts
  append-path ~/.gem/ruby/2.1.0/bin
end

# Only run this stuff if this is an interactive shell
if status --is-interactive
  set -x PAGER less
  set -x EDITOR vim
  set -x BROWSER chromium
  set -x CHROME_BIN chromium

  setup-keychain
end
