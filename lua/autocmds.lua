-- treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

-- highlight references to word under cursor (CoC)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.fn.CocActionAsync("highlight")
  end,
})
