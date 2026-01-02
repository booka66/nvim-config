add("folke/persistence.nvim")

require("persistence").setup()

map('n', '<leader>qs', function() require("persistence").load() end)
map('n', '<leader>ql', function() require("persistence").load({ last = true }) end)
map('n', '<leader>qd', function() require("persistence").stop() end)
