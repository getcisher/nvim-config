-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Switch to Normal Mode" })
  vim.cmd.quit()
end

require "lazy_setup"
require "polish"
require("lspconfig").gleam.setup {}

-- vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Switch to normal mode" })
-- vim.keymap.set("i", "jk", "<Esc>", { silent = true, desc = "Switch to normal mode" })

for _, method in ipairs { "textDocument/diagnostic", "workspace/diagnostic" } do
  local default_diagnostic_handler = vim.lsp.handlers[method]
  vim.lsp.handlers[method] = function(err, result, context, config)
    if err ~= nil and err.code == -32802 then return end
    return default_diagnostic_handler(err, result, context, config)
  end
end
-- local lspconfig = require("lspconfig") lspconfig["ts_ls"].setup({})

-- vim.api.nvim_set_keymap("n", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<C-a>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "<LocalLeader>a", "<cmd>CodeCompanionToggle<cr>", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("v", "ga", "<cmd>CodeCompanionAdd<cr>", { noremap = true, silent = true })
--
-- -- Expand 'cc' into 'CodeCompanion' in the command line
-- vim.cmd([[cab cc CodeCompanion]])

local opt = vim.opt
opt.wrap = true
