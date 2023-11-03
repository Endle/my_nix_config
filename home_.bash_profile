alias exa='eza'
alias dfs='cd /Users/zhenboli/src/fireSeqSearch/fire_seq_search_server && sh debug_server.sh'
export PATH=/Users/zhenboli/.local/bin:$PATH

export PS1="\W $ "


alias fv='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix --run "fava main.beancount"'
alias bc='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix'
alias bck='cd ~/beancount && nix-shell ~/.nixpkgs/bc.nix --run "bean-check main.beancount" && echo Finished'


asf() {
  cd ~/src/nixpkgs/pkgs/applications/misc/ArchiSteamFarm
  nix build .#ArchiSteamFarm --extra-experimental-features nix-command --extra-experimental-features flakes
  ./result/bin/ArchiSteamFarm
}
