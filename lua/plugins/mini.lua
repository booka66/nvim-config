vim.pack.add({
  { src = "https://github.com/echasnovski/mini.pick" },
  { src = "https://github.com/echasnovski/mini.indentscope" },
})

require("mini.indentscope").setup()
require("mini.pick").setup()
