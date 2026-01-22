{
  description = "my neovim config :3";

  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-unstable/nixexprs.tar.xz";
    neovim-nightly = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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

      forAllSystems =
        f:
        lib.genAttrs systems (
          system:
          f (
            import nixpkgs {
              inherit system;
              overlays = [ inputs.neovim-nightly.overlays.default ];
            }
          )
        );
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./nix/default.nix { inherit inputs; };
      });

      legacyPackages = forAllSystems (pkgs: {
        wrapNeovim = pkgs.callPackage ./nix/wrapper.nix { };
      });

      homeManagerModules.default = import ./nix/hm-module.nix inputs;

      devShells = forAllSystems (pkgs: {
        default = pkgs.callPackage ./nix/shell.nix { inherit pkgs; };
      });

      formatter = forAllSystems (pkgs: pkgs.callPackage ./nix/formatter.nix { inherit pkgs; });
    };
}
