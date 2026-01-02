-- globals

--- Global to add a plugin
---@param repo string
---@param opts? { checkout?: string }
function _G.add(repo, opts)
  local spec = { src = "https://github.com/" .. repo }
  if opts then
    for k, v in pairs(opts) do spec[k] = v end
  end
  vim.pack.add({ spec })
end

_G.map = vim.keymap.set

-- options
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = true
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.expandtab = true
vim.o.swapfile = false
vim.g.mapleader = " "
vim.o.signcolumn = "yes"
vim.o.undofile = true
vim.o.clipboard = "unnamedplus"
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.termguicolors = true
