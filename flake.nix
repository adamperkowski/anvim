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
    }:
    let
      inherit (nixpkgs) lib;
      systems = lib.systems.flakeExposed;

      forAllSystems = f: lib.genAttrs systems (system: f (import nixpkgs { inherit system; }));

      anvimVersion = self.shortRev or self.dirtyShortRev or "unknown";
    in
    {
      packages = forAllSystems (pkgs: {
        default = pkgs.callPackage ./nix/default.nix { inherit pkgs anvimVersion; };
      });

      formatter = forAllSystems (pkgs: pkgs.callPackage ./nix/formatter.nix { inherit pkgs; });
    };
}
