{
  pkgs,
  anvimVersion,
}:

let
  wrapNeovim = pkgs.callPackage ./wrapper.nix { };
in
wrapNeovim {
  pname = "anvim";
  versionSuffix = anvimVersion;
  userConfig = ../config;
}
