{
  vimPlugins,
  callPackage,
  nodejs,
  inputs,
  self ? inputs.self,
  anvimVersion ? self.shortRev or self.dirtyShortRev or "unknown",
  neovim-unwrapped,
  fetchFromGitea,
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
    (artio-nvim.overrideAttrs {
      src = fetchFromGitea {
        domain = "codeberg.org";
        owner = "comfysage";
        repo = "artio.nvim";
        rev = "9cf933d7c49b998e9689bc208066e6c5cd423398";
        hash = "sha256-8FlOkwVI573iKU00QwhepruQMkljx3bxjbo4X79DCtM=";
      };
    })

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
