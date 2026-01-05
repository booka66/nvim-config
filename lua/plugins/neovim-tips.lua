add("MunifTanjim/nui.nvim")
add("saxon1964/neovim-tips")

require("neovim_tips").setup({
  -- Path to user tips file
  user_file = vim.fn.stdpath("config") .. "/neovim_tips/user_tips.md",

  -- Prefix added to user tip titles to prevent conflicts
  user_tip_prefix = "[User] ",

  -- Show warnings when user tips have conflicting titles with builtin tips
  warn_on_conflicts = true,

  -- Daily tip mode: 0=off, 1=once per day, 2=every startup
  daily_tip = 1,
})

map("n", "<leader>nto", ":NeovimTips<CR>", { desc = "Neovim tips", silent = true })
map("n", "<leader>ntb", ":NeovimTipsBookmarks<CR>", { desc = "Bookmarked tips", silent = true })
map("n", "<leader>nte", ":NeovimTipsEdit<CR>", { desc = "Edit your Neovim tips", silent = true })
map("n", "<leader>nta", ":NeovimTipsAdd<CR>", { desc = "Add your Neovim tip", silent = true })
map("n", "<leader>nth", ":help neovim-tips<CR>", { desc = "Neovim tips help", silent = true })
map("n", "<leader>ntr", ":NeovimTipsRandom<CR>", { desc = "Show random tip", silent = true })
map("n", "<leader>ntp", ":NeovimTipsPdf<CR>", { desc = "Open Neovim tips PDF", silent = true })
