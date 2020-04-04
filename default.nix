{ }:

let
  sources = import ./nix/sources.nix;
  pkgs = import sources.nixpkgs { config = { }; };
  mkDerivation = import sources.mgmt pkgs;
in {
  home = import ./home.nix {
    inherit mkDerivation pkgs;
  };
}
