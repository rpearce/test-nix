pkgs: attrs:
  with pkgs;
  let
    home_dir = builtins.getEnv "HOME"; # @TODO dotfiles symlinking

    defaultAttrs = {
      args = [ ./builder.sh ];
      baseInputs = [ coreutils findutils which ];
      buildInputs = [];
      builder = "${bash}/bin/bash";
      dotfiles = {};
      setup = ./setup.sh;
      system = builtins.currentSystem;
    };

    combinedAttrs = (defaultAttrs // attrs);

    finalAttrs = (combinedAttrs // {
      dotfiles = lib.attrsets.mapAttrsToList
                  (name: value: builtins.path {
                    path = value;
                    name = lib.strings.validDerivationName "mgmt_${name}";
                  })
                  combinedAttrs.dotfiles;
    });
  in
    derivation finalAttrs
