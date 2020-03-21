#{ all-hies
#, pkgs
#, user
#, ...
#}:

#let

#in {
#  xdg = user.xdg;

#  home.packages = with pkgs; [
#    # CLI
#    ascii
#    bash
#    bash-completion
#    bat
#    cachix
#    coreutils
#    ctop
#    exercism
#    findutils
#    fswatch
#    gnupg
#    heroku
#    jq
#    ncdu
#    rename
#    ripgrep
#    ruby_2_6
#    speedtest-cli
#    tldr
#    #timetrack-cli
#    tree
#    zsh-completions

#    # node
#    nodejs-13_x
#    (yarn.override { nodejs = nodejs-13_x; })
#    nodePackages.node2nix

#    # haskell
#    cabal2nix
#    haskellPackages.ghcid
#    haskellPackages.hakyll
#    haskellPackages.hlint
#    haskellPackages.hoogle
#    haskellPackages.pandoc
#    haskellPackages.stylish-haskell
#    stack
#    (all-hies.selection { selector = p: { inherit (p) ghc883; }; })

#    # elm
#    elmPackages.elm
#    elmPackages.elm-format

#    # elixir
#    elixir

#    # git
#    gitAndTools.diff-so-fancy

#    # nix
#    nix-prefetch-git
#    niv
#  ];
#}

let
  #user = import ./user.nix;
  sources = import ./nix/sources.nix;
  config = { allowUnfree = true; };
  pkgs = (import sources.nixpkgs) { config = config; };
  mkDerivation = import ./mgmt.nix pkgs;
in mkDerivation {
  name = "hello-yo";
  buildInputs = with pkgs; [
    ascii
    bat
    cachix
    exercism
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
    ".cabal/config"     = ./dotfiles/cabal.cabal;
    ".gemrc"            = ./dotfiles/.gemrc;
    ".ghci"             = ./dotfiles/.ghci;
    ".inputrc"          = ./dotfiles/.inputrc;
    ".psqlrc"           = ./dotfiles/.psqlrc;
    ".ripgreprc"        = ./dotfiles/.ripgreprc;
    ".stack/config.yml" = ./dotfiles/stack.yaml;
    ".tmux.conf"        = ../conf/.tmux.conf;
  };
  #src = ./hello-2.10.tar.gz;
}
