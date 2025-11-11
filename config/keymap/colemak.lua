return function(opts)
  vim.keymap.set("n", "n", "h", opts)
  vim.keymap.set("n", "e", "j", opts)
  vim.keymap.set("n", "i", "k", opts)
  vim.keymap.set("n", "o", "l", opts)

  vim.keymap.set("n", "t", "i", opts)
  vim.keymap.set("n", "k", "o", opts)
  vim.keymap.set("n", "h", "g", opts)
end
