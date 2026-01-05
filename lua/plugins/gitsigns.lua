add("lewis6991/gitsigns.nvim")

require("gitsigns").setup({
  on_attach = function(bufnr)
    local gs = require("gitsigns")
    local function map(mode, l, r, desc)
      vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
    end
    map("n", "]h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "]c", bang = true })
      else
        gs.nav_hunk("next")
      end
    end, "Next Hunk")
    map("n", "[h", function()
      if vim.wo.diff then
        vim.cmd.normal({ "[c", bang = true })
      else
        gs.nav_hunk("prev")
      end
    end, "Prev Hunk")
    map("n", "<leader>hp", gs.preview_hunk_inline, "Preview Hunk Inline")
    map("n", "<leader>gb", function() gs.blame() end, "Blame Buffer")
    map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitsigns-blame",
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
  end,
})
