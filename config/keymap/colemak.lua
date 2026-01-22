local mappings = {
  h = "n",
  j = "e",
  k = "i",
  l = "o",
}

return function(opts)
  for rhs, lhs in pairs(mappings) do
    vim.keymap.set("n", lhs, rhs, opts)
    vim.keymap.set("n", "<C-w>" .. lhs, "<C-w>" .. rhs, opts)
    vim.keymap.set("n", "<C-w>" .. lhs:upper(), "<C-w>" .. rhs:upper(), opts)
  end

  vim.keymap.set("n", "<C-w>k", "<C-w>n")
  vim.keymap.set("n", "<C-w>m", "<C-w>o")

  vim.keymap.set("n", "t", "i", opts)
  vim.keymap.set("n", "k", "o", opts)
  vim.keymap.set("n", "h", "g", opts)

  vim.keymap.set("n", "<C-,>", "<C-o>", opts)
  vim.keymap.set("n", "<C-.>", "<C-i>", opts)
end
