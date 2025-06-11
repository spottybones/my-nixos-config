-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Better escape using jk in insert mode
vim.keymap.set("i", "jk", "<ESC>", { desc = "Escape to Normal Mode" })
