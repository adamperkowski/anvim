{
  lib,
  pkgs,
  config,
  ...
}@args:

{
  options.programs.anvim = {
    enable = lib.mkEnableOption "anvim";

    package = lib.mkOption {
      type = lib.types.package;
      default = pkgs.callPackage ./default.nix { inputs = args.inputs; };
    };
  };

  config = lib.mkIf config.programs.anvim.enable {
    home.packages = [ config.programs.anvim.package ];
  };
}
