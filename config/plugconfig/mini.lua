local icons = require("mini.icons")
local diff = require("mini.diff")

icons.setup({
  style = vim.env.TERM ~= "linux" and "glyph" or "ascii",
  filetype = {
    tera = { glyph = "󰅩", hl = "MiniIconsOrange" },
    just = { glyph = "󰚩", hl = "MiniIconsOrange" },
  },
  file = {
    [".envrc"] = { glyph = "", hl = "MiniIconsYellow" },
    [".luacheckrc"] = "lua",
    [".Justfile"] = "justfile",
    [".justfile"] = "justfile",
    ["Justfile"] = "justfile",
    ["justfile"] = "justfile",
  },
  lsp = {
    color = { glyph = "󰏘" },
    constant = { glyph = "󰏿" },
    constructor = { glyph = "󰒓" },
    event = { glyph = "󱐋" },
    file = { glyph = "󰈚" },
    ["function"] = { glyph = "󰊕" },
    property = { glyph = "󰖷" },
    snippet = { glyph = "󱄽" },
    string = { glyph = "“" },
    value = { glyph = "󰦨" },
    variable = { glyph = "󰆦" },
  },
})
icons.mock_nvim_web_devicons()

diff.setup({
  view = { style = "number" },
  delay = { text_change = 1000 },
})
