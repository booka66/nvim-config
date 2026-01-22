add("neoclide/coc.nvim", { checkout = "v0.0.82" })

local utils = require("utils")

map('n', 'gd', '<Plug>(coc-definition)', { silent = true })
map('n', 'gr', '<Plug>(coc-references)', { silent = true })
map('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
map('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
  { expr = true, silent = true })
map("n", "]e", function() utils.jump_and_copy_diagnostic("next") end, { silent = true, desc = "Next error" })
map("n", "[e", function() utils.jump_and_copy_diagnostic("prev") end, { silent = true, desc = "Previous error" })
map("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })
map("n", "<leader>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })
map("n", "<leader>cr", "<Plug>(coc-rename)", { silent = true })
map("n", "<leader>cl", ":CocRestart<CR>", { silent = true })

-- Signature help: <C-k> in insert mode
map('i', '<C-k>', '<Cmd>call CocActionAsync("showSignatureHelp")<CR>', { silent = true })
