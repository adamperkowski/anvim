require("catppuccin").setup({
  flavour = "mocha",
  show_end_of_buffer = true,
  default_integrations = false,
  integraions = {
    cmp = true,
    gitsigns = true,
    native_lsp = true,
    indent_blankline = {
      enabled = true,
    },
  },
})

vim.cmd.colorscheme("catppuccin")
