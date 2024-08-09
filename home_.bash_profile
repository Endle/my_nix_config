# alias exa='eza'
alias dfs='cd /Users/zhenboli/src/fireSeqSearch/fire_seq_search_server && sh debug_server_mac.sh'
export PATH=/Users/zhenboli/.local/bin:$PATH

export PS1="\W $ "


alias fv='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix --run "fava main.beancount"'
alias bc='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix'
alias bck='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix --run "bean-check main.beancount" && echo Finished'


alias asf='ArchiSteamFarm'

nb () {
  nix build .#"$1"  --extra-experimental-features nix-command --extra-experimental-features flakes
}

ms () {
  # nix-shell ~/.nixpkgs/ms.nix --run "cd /Users/zhenboli/src/mhc_predict/ && jupyter notebook"
  nix-shell -p python310 --run \
    "source ~/src/ms_env/bin/activate && cd /Users/zhenboli/src/mhc_predict/ && jupyter notebook"
}

rs () {
  nix-shell -p rustc cargo libiconv
}
export RUSTC_WRAPPER=$(which sccache)
export SCCACHE_CACHE_SIZE="50G"


# Homebrew: put their path at last
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
# export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export LIMA_HOME='/Volumes/extend/virtual_machine_images/lima_home'
