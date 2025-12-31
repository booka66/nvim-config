local keyset = vim.keymap.set
local utils = require("utils")
utils.setup_dashboard_command()

-- general
keyset('n', '<leader>o', ':update<CR>:source $MYVIMRC<CR>')
keyset('n', '<leader>w', ':write<CR>')
keyset('n', '<leader>qq', ':quitall<CR>')
keyset('n', '<Esc>', ':nohlsearch<CR>')
keyset('n', '<leader>fy', function() utils.copy_relative_path() end, { silent = true, desc = "Copy relative file path" })
keyset('n', '<leader>fY', function() utils.copy_filename() end, { silent = true, desc = "Copy filename" })

-- navigation
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')
keyset('i', '<C-h>', '<C-o><C-w>h')
keyset('i', '<C-j>', '<C-o><C-w>j')
keyset('i', '<C-k>', '<C-o><C-w>k')
keyset('i', '<C-l>', '<C-o><C-w>l')

-- tabs
keyset('n', 'H', ':tabprevious<CR>')
keyset('n', 'L', ':tabnext<CR>')
keyset('n', '<leader>to', ':tabo<CR>')

-- splits
keyset('n', '<leader>\\', ':vsplit<CR><C-w>l')
keyset('n', '<leader>-', ':split<CR><C-w>j')
