vim.pack.add({ { src = "https://github.com/neoclide/coc.nvim", checkout = "v0.0.82" } })

local utils = require("utils")

vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.keymap.set('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
vim.keymap.set('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
  { expr = true, silent = true })
vim.keymap.set("n", "]e", function() utils.jump_and_copy_diagnostic("next") end, { silent = true, desc = "Next error" })
vim.keymap.set("n", "[e", function() utils.jump_and_copy_diagnostic("prev") end,
  { silent = true, desc = "Previous error" })
vim.keymap.set("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })
vim.keymap.set("n", "<leader>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })
vim.keymap.set("n", "<leader>cr", "<Plug>(coc-rename)", { silent = true })
vim.keymap.set("n", "<leader>cl", ":CocRestart<CR>", { silent = true })
