require("anvim.keymap")

vim.opt.mouse = ""
vim.opt.number = true

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.g.rustfmt_autosave = 1

vim.diagnostic.config({
  signs = false,
  underline = true,
  virtual_text = false,
  virtual_lines = {
    current_line = true,
  },
  update_in_insert = true,
})

require("anvim.plugconfig")

for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
  vim.api.nvim_set_hl(0, group, {})
end
