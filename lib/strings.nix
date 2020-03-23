{ lib }:
let
in rec {
  inherit (builtins) genList length;
  inherit (lib) lowerChars replaceStrings stringToCharacters upperChars;

  /* Determines a valid nix store name for a path.

     Type: stringToValidNixPath :: string -> string

     Example:
       stringToValidNixPath "foo_" ".stack/config.yml"
       => "foo_.stackconfig.yml"
       stringToValidNixPath "  " ".stack/config.yml"
       => "safePrefix_.stackconfig.yml"
  */

  stringToValidNixPath = prefix: path:
    let
      safePrefix = if replaceStrings [" "] [""] prefix == "" then "safePrefix_" else prefix;

      listToEmptyStrings = list: genList (x: "") (length list);

      safeChars = lowerChars ++ upperChars ++ stringToCharacters "0123456789+.=?_";
      safeCharsEmpty = listToEmptyStrings safeChars;

      unsafeChars = stringToCharacters (replaceStrings safeChars safeCharsEmpty path);
      unsafeCharsEmpty = listToEmptyStrings unsafeChars;

      validPath = replaceStrings unsafeChars unsafeCharsEmpty path;
    in
      "${safePrefix}${validPath}";
}

