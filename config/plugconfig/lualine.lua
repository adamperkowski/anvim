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
