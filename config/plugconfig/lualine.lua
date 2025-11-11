local c = require("catppuccin.palettes").get_palette("mocha")

local lualine_mocha = {
  normal = {
    a = { fg = c.mantle, bg = c.mauve, gui = "bold" },
    b = { fg = c.overlay2, bg = c.surface0 },
    c = { fg = c.overlay0, bg = c.mantle },
  },
  insert = {
    a = { fg = c.mantle, bg = c.lavender, gui = "bold" },
    b = { fg = c.overlay2, bg = c.surface0 },
    c = { fg = c.overlay0, bg = c.mantle },
  },
  visual = {
    a = { fg = c.mantle, bg = c.maroon, gui = "bold" },
    b = { fg = c.overlay2, bg = c.surface0 },
    c = { fg = c.overlay0, bg = c.mantle },
  },
  replace = {
    a = { fg = c.mantle, bg = c.yellow, gui = "bold" },
    b = { fg = c.overlay2, bg = c.surface0 },
    c = { fg = c.overlay0, bg = c.mantle },
  },
  command = {
    a = { fg = c.mantle, bg = c.teal, gui = "bold" },
    b = { fg = c.overlay2, bg = c.surface0 },
    c = { fg = c.overlay0, bg = c.mantle },
  },
}

local mode_map = {
  ["n"] = "hello :3",
  ["i"] = "type >ᴗ<",
  ["v"] = "visual oᴗo",
  ["V"] = "visual OᴗO",
  [""] = "visual UᴗU",
  ["R"] = "replace -ᴗ-",
  ["c"] = "cmd xᴗx",
  ["no"] = "no ???",
}

require("lualine").setup({
  options = {
    theme = lualine_mocha,
    section_separators = { left = "", right = "" },
    component_separators = { left = "|", right = "|" },
  },

  sections = {
    lualine_a = {
      function()
        return mode_map[vim.api.nvim_get_mode().mode] or "wtf lol xD huh? STUPID! BONK!"
      end,
    },
    lualine_b = { "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = { "encoding", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
})
