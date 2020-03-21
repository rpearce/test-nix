pkgs: attrs:
  with pkgs;
  let defaultAttrs = {
    args = [ ./builder.sh ];
    baseInputs = [ coreutils findutils which ];
    buildInputs = [];
    builder = "${pkgs.bash}/bin/bash";
    #dotfiles = {};
    setup = ./setup.sh;
    system = builtins.currentSystem;
  };
  in
  derivation (defaultAttrs // attrs)
