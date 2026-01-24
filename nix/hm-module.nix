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
    mkPackageOption
    types
    mkIf
    ;

  cfg = config.programs.anvim;

  pkgs' = import ../default.nix { inherit pkgs inputs; };
in
{
  options.programs.anvim = {
    enable = mkEnableOption "anvim";

    package = mkPackageOption pkgs' "anvim" { };

    defaultEditor = mkOption {
      type = types.bool;
      default = false;
    };
  };

  config = mkIf cfg.enable {
    programs.anvim.package = pkgs'.anvim.override {
      basePackage = inputs.neovim-nightly-overlay.packages.${pkgs.stdenv.hostPlatform.system}.neovim;
    };

    home.packages = [ cfg.package ];
    home.sessionVariables = mkIf cfg.defaultEditor { EDITOR = "anvim"; };
  };
}
