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


local keyset = vim.keymap.set
local utils = require("utils")
utils.setup_dashboard_command()

keyset('n', '<leader>o', ':update<CR>:source $MYVIMRC<CR>')
keyset('n', '<leader>w', ':write<CR>')
keyset('n', '<leader>qq', ':quitall<CR>')
keyset('n', '<Esc>', ':nohlsearch<CR>')
keyset('n', '<leader>fy', function() utils.copy_relative_path() end, { silent = true, desc = "Copy relative file path" })
keyset('n', '<leader>fY', function() utils.copy_filename() end, { silent = true, desc = "Copy filename" })

-- CoC keymaps
keyset('n', 'gd', '<Plug>(coc-definition)', { silent = true })
keyset('n', 'gr', '<Plug>(coc-references)', { silent = true })
keyset('n', 'K', ':call CocActionAsync("doHover")<CR>', { silent = true })
keyset('i', '<CR>', [[coc#pum#visible() ? coc#pum#confirm() : "\<CR>"]], { expr = true, silent = true })
keyset("n", "]e", function() utils.jump_and_copy_diagnostic("next") end, { silent = true, desc = "Next error" })
keyset("n", "[e", function() utils.jump_and_copy_diagnostic("prev") end, { silent = true, desc = "Previous error" })
keyset("n", "<leader>ca", "<Plug>(coc-codeaction)", { silent = true })
keyset("n", "<leader>a", ":<C-u>CocList diagnostics<cr>", { silent = true, nowait = true })


-- Navigation
keyset('n', '<C-h>', '<C-w>h')
keyset('n', '<C-j>', '<C-w>j')
keyset('n', '<C-k>', '<C-w>k')
keyset('n', '<C-l>', '<C-w>l')


-- Plugins

vim.pack.add({
  { src = "https://github.com/vague2k/vague.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/folke/persistence.nvim" },
  { src = "https://github.com/folke/snacks.nvim" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
  { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
  { src = "https://github.com/neoclide/coc.nvim",            checkout = "v0.0.82" },
  { src = "https://github.com/blazkowolf/gruber-darker.nvim" },
})

require "mini.pick".setup()
keyset('n', '<leader><leader>', function() Snacks.picker.smart() end)
keyset('n', '<leader>h', ':Pick help<CR>')

require "oil".setup()
keyset('n', '<leader>e', function()
  if vim.bo.filetype == 'oil' then
    require('oil').close()
  else
    require('oil').open()
  end
end)

require "conform".setup({
  formatters_by_ft = {
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    css = { "prettierd" },
    html = { "prettierd" },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
})

require "persistence".setup()
keyset('n', '<leader>qs', function() require("persistence").load() end)
keyset('n', '<leader>ql', function() require("persistence").load({ last = true }) end)
keyset('n', '<leader>qd', function() require("persistence").stop() end)

require "neoscroll".setup({
  mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "zt", "zz", "zb" },
  hide_cursor = false,
  stop_eof = true,
  respect_scrolloff = false,
  cursor_scrolls_alone = true,
  duration_multiplier = 0.8,
  easing = "cubic",
  pre_hook = nil,
  post_hook = nil,
  performance_mode = false,
  ignored_events = { "WinScrolled", "CursorMoved" },
})

local image_data = utils.get_random_image()
require "snacks".setup({
  picker = {
    enabled = true,
    layout = "vertical",
  },
  notifier = {
    enabled = true
  },
  statuscolumn = {
    enabled = true
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
keyset('n', '<leader>gg', function() Snacks.lazygit() end)
keyset('n', '<leader>sg', function() Snacks.picker.grep() end)
keyset('n', '<leader>sw', function() Snacks.picker.grep_word() end)
keyset('n', '<leader>.', function() Snacks.scratch() end)
keyset('n', '<leader>S', function() Snacks.scratch.select() end)

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

vim.cmd("colorscheme vague")
