local utils = require("utils")
utils.setup_dashboard_command()

-- general
map('n', '<leader>o', ':update<CR>:source $MYVIMRC<CR>')
map('n', '<leader>w', ':write<CR>')
map('n', '<leader>qq', ':quitall<CR>')
map('n', '<Esc>', ':nohlsearch<CR>')
map('n', '<leader>fy', function() utils.copy_relative_path() end, { silent = true, desc = "Copy relative file path" })
map('n', '<leader>fY', function() utils.copy_filename() end, { silent = true, desc = "Copy filename" })

-- navigation
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')
map('i', '<C-h>', '<C-o><C-w>h')
map('i', '<C-j>', '<C-o><C-w>j')
map('i', '<C-k>', '<C-o><C-w>k')
map('i', '<C-l>', '<C-o><C-w>l')

-- tabs
map('n', 'H', ':tabprevious<CR>')
map('n', 'L', ':tabnext<CR>')
map('n', '<leader>to', ':tabo<CR>')

-- splits
map('n', '<leader>\\', ':vsplit<CR><C-w>l')
map('n', '<leader>-', ':split<CR><C-w>j')
