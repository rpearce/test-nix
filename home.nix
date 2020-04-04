{ mkDerivation
, pkgs
}:

mkDerivation {
  name = "mgmt-home";

  buildInputs = with pkgs; [
    ascii
    #bat
    #exercism
    #findutils
    #gnupg
    #jq
    #ncdu
    #rename
    #ripgrep
    #speedtest-cli
    #tldr
    #tree

    ## git
    #git
    #gitAndTools.diff-so-fancy

    ## nix
    #cachix
    #niv
  ];

  dotfiles = {
    ".gemrc"            = ./dotfiles/.gemrc;
    ".ghci"             = ./dotfiles/.ghci;
    ".inputrc"          = ./dotfiles/.inputrc;
    ".psqlrc"           = ./dotfiles/.psqlrc;
    ".ripgreprc"        = ./dotfiles/.ripgreprc;
    ".stack/config.yml" = ./dotfiles/stack.yaml;
    ".tmux.conf"        = ./dotfiles/.tmux.conf;
    "cabal/config"      = ./dotfiles/cabal.cabal;
  };
}
