vim.pack.add({ { src = "https://github.com/3rd/image.nvim" } })
require("image").setup()

vim.pack.add({ { src = "https://codeberg.org/koibtw/nidhogg.nvim" } })

require("anvim.keymap")

vim.cmd.packadd("nvim.undotree")

vim.o.grepprg = "grep -rni --"
vim.o.grepformat = "%f:%l:%c:%m"

require("vim._extui").enable({ enable = true, msg = { target = "msg" } })

vim.o.mouse = ""
vim.o.number = true
vim.o.exrc = true

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = vim.fn.stdpath("state") .. "/undodir"
vim.o.undofile = true

vim.o.hidden = true
vim.o.sessionoptions = "help,tabpages,winsize"

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
