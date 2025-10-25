{ pkgs }:

pkgs.treefmt.withConfig {
  runtimeInputs = with pkgs; [
    nixfmt
    stylua
  ];

  settings = {
    on-unmatched = "info";
    tree-root-file = "flake.nix";

    formatter = {
      nixfmt = {
        command = "nixfmt";
        includes = [ "*.nix" ];
      };

      stylua = {
        command = "stylua";
        includes = [ "*.lua" ];
      };
    };
  };
}
