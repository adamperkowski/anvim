{
  lib,
  fetchFromGitea,

  vimPlugins,

  fd,
  fzf,
  ripgrep,

  wrapNeovim,

  anvimPlugins,
  neovim-unwrapped,
  basePackage ? neovim-unwrapped,
  anvimVersion ? "unstable",
}:
let
  inherit (lib)
    pipe
    isDerivation
    flatten
    attrValues
    filter
    partition
    ;

  partionPlugins =
    plugins:
    let
      parts = partition (e: e.passthru.start or false) plugins;
    in
    {
      start = parts.right;
      opt = parts.wrong;
    };

  patrionedPlugins = pipe anvimPlugins [
    attrValues
    (filter isDerivation)
    partionPlugins
  ];
in
wrapNeovim {
  pname = "anvim";
  versionSuffix = anvimVersion;

  userConfig = ../../config;

  inherit basePackage;

  startPlugins = flatten [
    patrionedPlugins.start
    vimPlugins.nvim-lspconfig
  ];

  optPlugins =
    with vimPlugins;
    flatten [
      patrionedPlugins.opt

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

      blink-cmp

      indent-blankline-nvim
      nvim-colorizer-lua

      mini-icons
      mini-diff
      mini-pairs

      (cord-nvim.overrideAttrs { doCheck = false; })

      jule-nvim
    ];

  extraPackages = [
    fd
    fzf
    ripgrep
  ];
}
