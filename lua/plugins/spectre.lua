add("nvim-pack/nvim-spectre")
add("nvim-lua/plenary.nvim")

require("spectre").setup()

local utils = require("utils")

vim.keymap.set("n", "<leader>rr", function()
	require("spectre").open({ is_insert_mode = true })
	if utils.is_window_vertical() then
		vim.cmd("wincmd J") -- Move spectre window to bottom
	end
end, { desc = "Open Spectre (adaptive layout)" })
