#### User paths
# If path doesn't contain $HOME/bin, add it.  Be careful what you put there:
# It's earlier in the path search than any other directory!
if [ -d ~/bin ]; then
    export PATH=~/bin:$PATH
fi

if [ -d ~/prefix ]; then
    export PATH=~/prefix/bin:$PATH
    export MANPATH=~/prefix/share/man:$MANPATH
    export INFOPATH=~/prefix/share/info:$INFOPATH
fi

if [ -d /opt/bin ]; then
    export PATH=$PATH:/opt/bin
    export MANPATH=$MANPATH:/opt/man
    export INFOPATH=$INFOPATH:/opt/info
fi

if [ -d ~/programs/android-sdk ]; then
    export ANDROID_HOME=$HOME/programs/android-sdk
    export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
fi

if [ -d ~/programs/android-ndk ]; then
    export ANDROID_NDK=$HOME/programs/android-ndk
    export PATH=$PATH:$ANDROID_NDK
fi

if [ -d ~/programs/go ]; then
    export GOROOT=~/programs/go
    export PATH=$PATH:$GOROOT/bin
fi

if [ -d ~/code/scripts ]; then
    export PATH=$PATH:~/code/scripts
fi

if [ -d ~/.gem/ruby/2.0.0/bin ]; then
    export PATH=$PATH:~/.gem/ruby/2.0.0/bin
fi
