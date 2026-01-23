-- treesitter
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- highlight yank
vim.api.nvim_set_hl(0, "YankHighlight", { bg = "#8fbfdc", fg = "#000000" })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "YankHighlight", timeout = 200 })
  end,
})

-- highlight references to word under cursor (CoC)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.fn.CocActionAsync("highlight")
  end,
})
