local mappings = {
  h = "n",
  j = "e",
  k = "i",
  l = "o",
}

return function(opts)
  for lhs, rhs in pairs(mappings) do
    vim.keymap.set("n", lhs, rhs, opts)
    vim.keymap.set("n", "<C-w>" .. lhs, "<C-w>" .. rhs, opts)
    vim.keymap.set("n", "<C-w>" .. lhs:upper(), "<C-w>" .. rhs:upper(), opts)
  end

  vim.keymap.set("n", "<C-w>n", "<C-w>k")
  vim.keymap.set("n", "<C-w>o", "<C-w>m")
  vim.keymap.set("n", "<C-w>i", "<nop>")

  vim.keymap.set("n", "t", "i", opts)
  vim.keymap.set("n", "k", "o", opts)
  vim.keymap.set("n", "h", "g", opts)
end
