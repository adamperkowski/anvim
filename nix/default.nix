{
  pkgs,
  inputs,
  self ? inputs.self,
  anvimVersion ? self.shortRev or self.dirtyShortRev or "unknown",
}:

let
  wrapNeovim = pkgs.callPackage ./wrapper.nix { };
in
wrapNeovim {
  pname = "anvim";
  versionSuffix = anvimVersion;
  userConfig = ../config;

  plugins = with pkgs.vimPlugins; [
    catppuccin-nvim

    nvim-lspconfig

    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path

    indent-blankline-nvim
    nvim-autopairs
    undotree
    gitsigns-nvim
    copilot-lua
    nvim-colorizer-lua

    cord-nvim
    vim-wakatime

    jule-nvim
  ];

  extraPackages = with pkgs; [
    nodejs
  ];
}
