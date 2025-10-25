{
  lib,
  pkgs,
  config,
  ...
}@args:

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
      default = pkgs.callPackage ./default.nix { inputs = args.inputs; };
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
