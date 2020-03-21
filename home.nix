let
  #user = import ./user.nix;
  sources = import ./nix/sources.nix;
  pkgs = (import sources.nixpkgs) {
    config = {
      allowUnfree = true;
    };
  };
  mkDerivation = import ./mgmt.nix pkgs;
in mkDerivation {
  name = "hello-yo";
  buildInputs = with pkgs; [
    ascii
    bat
    cachix
    #exercism
    findutils
    gnupg
    jq
    ncdu
    rename
    ripgrep
    speedtest-cli
    tldr
    tree

    # git
    #git
    #gitAndTools.diff-so-fancy

    # haskell
    #haskellPackages.hlint
    #haskellPackages.hoogle
    #haskellPackages.stylish-haskell
    #stack

    # nodejs
    #nodejs-13_x
    #(yarn.override { nodejs = nodejs-13_x; })
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
  #src = ./hello.tar.gz;
}
