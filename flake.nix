{
  description = "my neovim config :3";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;

      forAllSystems = f: lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./nix/default.nix { inherit inputs; };
      });

      homeManagerModules.default = ./nix/hm-module.nix;

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./nix/shell.nix { inherit pkgs; };
      });

      formatter = forAllSystems (pkgs: pkgs.callPackage ./nix/formatter.nix { inherit pkgs; });
    };
}
