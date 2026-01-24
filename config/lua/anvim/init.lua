-- load plugins

vim.iter(vim.api.nvim_get_runtime_file("lua/anvim/plugins/*.lua", true)):each(function(file)
  local name = string.gsub(vim.fs.basename(file), "%.lua$", "")
  require("lynn").import("anvim.plugins." .. name, true)
end)
require("lynn").setup()

-- init

require("anvim.lsp")
require("anvim.keymap")

vim.o.grepprg = vim.fn.executable("rg") == 1 and "rg --vimgrep -. --" or "grep -rni --"
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

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "help",
  callback = function()
    vim.cmd.wincmd("L")
  end,
})
