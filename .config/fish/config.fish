# Disable greeting message
set fish_greeting ""

function -a path prepend-path
    if [ -d $path ]
        set -U fish_user_paths $path $fish_user_paths
        return 0
    end
    return 1
end

function -a path append-path
    if [ -d $path ]
        set -U fish_user_paths $fish_user_paths $path
        return 0
    end
    return 1
end

function verify-agent-vars
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

function save-agent-vars
    set -Ux SSH_AGENT_PID $SSH_AGENT_PID
    set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    set -Ux SSH_CLIENT $SSH_CLIENT
    set -Ux SSH_CONNECTION $SSH_CONNECTION
    set -Ux SSH_TTY $SSH_TTY
end

function setup-keychain
    if verify-agent-vars
        save-agent-vars
        return 0
    end

    eval (ssh-agent -c)
    if verify-agent-vars
        save-agent-vars
    else
        return 1
    end
end

if status -l
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

if status -i
    set -x PAGER less
    set -x EDITOR vim
    set -x BROWSER chromium
    set -x CHROME_BIN chromium
    set -x _JAVA_AWT_WM_NONREPARENTING 1

    setup-keychain
end
