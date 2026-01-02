add("stevearc/oil.nvim")

require("oil").setup()

map('n', '<leader>e', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    require('oil').open()
  end
end)
