add("folke/snacks.nvim")

local utils = require("utils")
local image_data = utils.get_random_image()

require("snacks").setup({
  picker = {
    enabled = true,
    layout = "vertical",
  },
  notifier = {
    enabled = true
  },
  statuscolumn = {
    enabled = true,
    git = {
      patterns = { "GitSigns" },
    },
  },
  scratch = {
    enabled = true,
  },
  dashboard = {
    enabled = true,
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":Pick files" },
        {
          icon = " ",
          key = "s",
          desc = "Restore Session",
          action = function()
            require("persistence").load()
          end
        },
        { icon = " ", key = "q", desc = "Quit",      action = ":qa" },
      },
    },
    sections = {
      {
        section = "terminal",
        cmd = "echo " .. vim.fn.shellescape(image_data.image),
        height = image_data.height,
        padding = 1,
      },
      { section = "keys",         gap = 1,   padding = 1 },
      { section = "recent_files", limit = 8, padding = 1 },
    },
  },
})

map('n', '<leader><leader>', function() Snacks.picker.smart() end)
map('n', '<leader>H', ':Pick help<CR>')
map('n', '<leader>gg', function() Snacks.lazygit() end)
map('n', '<leader>sg', function() Snacks.picker.grep() end)
map('n', '<leader>sw', function() Snacks.picker.grep_word() end)
map('n', '<leader>.', function() Snacks.scratch() end)
map('n', '<leader>S', function() Snacks.scratch.select() end)
