{ config ? { nixPkgs = {}; }
}:

let
  pkgSrc = (import ./sources.nix).nixpkgs;
in {
  #nixpkgs = import pkgSrc { inherit (config.nixPkgs); };
  nixpkgs = import pkgSrc;
}
