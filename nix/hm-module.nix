inputs:
{
  lib,
  pkgs,
  config,
  ...
}:

let
  inherit (lib)
    mkEnableOption
    mkOption
    types
    mkIf
    ;

  cfg = config.programs.anvim;
in
{
  options.programs.anvim = {
    enable = mkEnableOption "anvim";

    package = mkOption {
      type = types.package;
      default = pkgs.callPackage ./default.nix {
        inputs = inputs;
        neovim-unwrapped = inputs.neovim-nightly.packages.${pkgs.stdenv.hostPlatform.system}.default;
      };
    };

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
    home.sessionVariables = mkIf cfg.defaultEditor { EDITOR = "anvim"; };
  };
}
