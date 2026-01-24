require("evergarden").setup({
  theme = {
    variant = "fall",
    accent = "green",
  },
  cache = false,
  default_integrations = false,
  integraions = {
    cmp = true,
    gitsigns = true,
    lualine = true,
    indent_blankline = {
      enable = true,
    },
  },
})

vim.cmd.colorscheme("evergarden")
