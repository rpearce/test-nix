let
  sources = import ./nix/sources.nix;
  nixpkgs = (import sources.nixpkgs) {
    config = {
      allowUnfree = true;
    };
  };
  allPkgs = nixpkgs // pkgs;
  callPackage = path: overrides:
    let f = import path;
    in f ((builtins.intersectAttrs (builtins.functionArgs f) allPkgs) // overrides);
  pkgs = with nixpkgs; {
    mkDerivation = import ../mgmt/mgmt.nix nixpkgs;
    home = callPackage ./mgmt-home.nix { };
  };
in pkgs
