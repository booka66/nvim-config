add("karb94/neoscroll.nvim")

require("neoscroll").setup({
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "zt", "zz", "zb" },
  hide_cursor = false,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  duration_multiplier = 0.8,
  easing = "cubic",
  pre_hook = nil,
  post_hook = nil,
  performance_mode = false,
  ignored_events = { "WinScrolled", "CursorMoved" },
})
