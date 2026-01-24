{
  pkgs ? import <nixpkgs> {
    inherit system;
    overlays = [ ];
    config.allowUnfree = true;
  },
  lib ? pkgs.lib,
  system ? builtins.currentSystem,

  # wow this is hacky
  inputs,
  self ? inputs.self,
  anvimVersion ? self.shortRev or self.dirtyRev or "unknown",
}:
let
  packages = lib.makeScope pkgs.newScope (self: {
    anvim = self.callPackage ../pkgs/anvim/package.nix { inherit anvimVersion; };
    anvimPlugins = self.callPackage ../pkgs/anvim-plugins/package.nix { };
    inherit (inputs.gift-wrap.legacyPackages.${pkgs.stdenv.hostPlatform.system}) wrapNeovim;
  });
in
packages
