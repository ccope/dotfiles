-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- ~/.config/nvim/lua/config/autocmds.lua

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Group for custom filetype settings
local ft_group = augroup("CustomFileTypes", { clear = true })

-- FileType-specific indentation
autocmd("FileType", {
  pattern = "puppet",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  group = ft_group,
})

autocmd("FileType", {
  pattern = "python",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  group = ft_group,
})

autocmd("FileType", {
  pattern = "ruby",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
  end,
  group = ft_group,
})

autocmd("FileType", {
  pattern = "xml",
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
  group = ft_group,
})

autocmd("FileType", {
  pattern = "yaml",
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.expandtab = true
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
  group = ft_group,
})

-- -- Filetype detection for *.h files
-- autocmd({ "BufRead", "BufNewFile" }, {
--   pattern = "*.h",
--   callback = function()
--     vim.bo.filetype = "c"
--   end,
--   group = augroup("FileTypeDetect", { clear = true }),
-- })

-- -- Auto-close doc popup
-- autocmd({ "CursorMovedI", "InsertLeave" }, {
--   pattern = "*",
--   callback = function()
--     if vim.fn.pumvisible() == 0 then
--       pcall(vim.cmd.pclose)
--     end
--   end,
-- })

require("config.commands")
