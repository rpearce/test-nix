let
  sources = import ./nix/sources.nix;
  pkgs = (import sources.nixpkgs) { config = { allowUnfree = true; }; };
  mkDerivation = import sources.mgmt pkgs;
in {
  home = import ./mgmt-home.nix {
    mkDerivation = mkDerivation;
    pkgs = pkgs;
  };
}
