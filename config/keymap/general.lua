return function(opts)
  vim.keymap.set("n", "<C-p>", "<cmd>_dP<cr>", opts)
  vim.keymap.set("n", "<C-t>", vim.cmd.Ex, opts)
  vim.keymap.set("n", "<F5>", vim.cmd.Undotree, opts)

  vim.keymap.set("n", "E", "<cmd>m .+1<cr>", opts)
  vim.keymap.set("n", "I", "<cmd>m .-2<cr>", opts)
end
