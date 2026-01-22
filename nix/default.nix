{
  vimUtils,
  vimPlugins,
  callPackage,
  nodejs,
  inputs,
  self ? inputs.self,
  anvimVersion ? self.shortRev or self.dirtyShortRev or "unknown",
  neovim-unwrapped,
  fetchFromGitea,
  fetchgit,
  lua-language-server,
}:

let
  wrapNeovim = callPackage ./wrapper.nix { inherit neovim-unwrapped; };
in
wrapNeovim {
  pname = "anvim";
  versionSuffix = anvimVersion;
  userConfig = ../config;

  plugins = with vimPlugins; [
    evergarden-nvim
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

    blink-cmp

    indent-blankline-nvim
    nvim-autopairs
    nvim-colorizer-lua

    mini-icons
    mini-diff

    (cord-nvim.overrideAttrs { doCheck = false; })

    jule-nvim
  ];

  extraPackages = [
    nodejs
    lua-language-server
  ];
}
