# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

. "$HOME/.cargo/env"

export RUSTC_WRAPPER=$(which sccache)
export SCCACHE_CACHE_SIZE="50G"

alias cdm='cd /dev/shm'

alias dfs="cd ~/src/fireSeqSearch/fire_seq_search_server && sh debug_server.sh"




# export WINESERVER=/home/lizhenbo/src/wine/wine
# export WINE=$WINESERVER

export WINE_SOURCE="/home/lizhenbo/src/wine"
export WINE=/home/lizhenbo/src/wine64/wine
alias wi="$WINE"
alias wk='~/src/winetricks/src/winetricks'
alias cdwine="cd $WINE_SOURCE"
alias cdp="cd $WINE_SOURCE/dlls/propsys"
alias cdpb="cd /home/lizhenbo/src/wine64/dlls/propsys"
export ROBOCOPY_PATH="programs/robocopy"
alias cdr="cd $WINE_SOURCE/$ROBOCOPY_PATH"
alias cdrb="cd /home/lizhenbo/src/wine64/$ROBOCOPY_PATH"
alias wp='cd /home/lizhenbo/.wine/drive_c/Program\ Files && exa'

function getwine {
    cd "$WINE_SOURCE"
    git checkout master
    git pull origin master
    cscope -bkqR &
}

function mkwine_only {
    export JOBS=30
    export CFLAGS="-O0 -g"
    export CROSSCFLAGS="$CFLAGS"
    cd "$WINE_SOURCE"
    cd ../wine64
    make -j$JOBS
    cd ../wine32
    make -j$JOBS
    cd "$WINE_SOURCE"
}

function mkw64 {
    export JOBS=30
    export CFLAGS="-O0 -g"
    export CROSSCFLAGS="$CFLAGS"
    cd "$WINE_SOURCE"
    cd ../wine64
    CC="sccache gcc"  ../wine/configure --enable-win64
    make -j$JOBS
    cd "$WINE_SOURCE"
}
function mkwine {
    export JOBS=30
    export CFLAGS="-O0 -g"
    export CROSSCFLAGS="$CFLAGS"
    cd "$WINE_SOURCE"
    cd ../wine64
    CC="sccache gcc"  ../wine/configure --enable-win64
    cd ../wine32
    PKG_CONFIG_PATH=/usr/lib/pkgconfig CC="sccache gcc -m32"  CROSSCC="sccache i686-w64-mingw32-gcc" \
        ../wine/configure --with-wine64=../wine64
    mkwine_only
    cd "$WINE_SOURCE"
}
export PATH="$PATH:~/src/WineMagicPrefix"


alias gst='git status -uno'
alias gcm='git commit -av --signoff'
function export_patch()
{
    branch="master"
    folder=$(date +%Y-%m-%d-%T)
    folder="/dev/shm/patch"-$folder
    mkdir $folder
    git format-patch --attach $branch -o $folder
}
alias gpat='git diff master>/dev/shm/$(date +%Y-%m-%d-%H_%M).txt'

alias bc='cd /home/lizhenbo/apps/resilio_bin/folders/zhenbo_doc/finance/beancount'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
