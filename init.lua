require("options")
require("keymaps")
require("autocmds")

-- Load all plugin configs
local plugin_dir = vim.fn.stdpath("config") .. "/lua/plugins"
for _, file in ipairs(vim.fn.glob(plugin_dir .. "/*.lua", true, true)) do
  local name = file:match("([^/]+)%.lua$")
  require("plugins." .. name)
end
