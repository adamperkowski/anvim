{
  vimPlugins,
  callPackage,
  nodejs,
  inputs,
  self ? inputs.self,
  anvimVersion ? self.shortRev or self.dirtyShortRev or "unknown",
  neovim-unwrapped,
}:

let
  wrapNeovim = callPackage ./wrapper.nix { inherit neovim-unwrapped; };
in
wrapNeovim {
  pname = "anvim";
  versionSuffix = anvimVersion;
  userConfig = ../config;

  plugins = with vimPlugins; [
    catppuccin-nvim
    lualine-nvim
    artio-nvim

    nvim-lspconfig

    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path

    indent-blankline-nvim
    nvim-autopairs
    gitsigns-nvim
    nvim-colorizer-lua

    (cord-nvim.overrideAttrs { doCheck = false; })

    jule-nvim
  ];

  extraPackages = [
    nodejs
  ];
}
