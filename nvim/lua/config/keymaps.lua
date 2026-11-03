-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Fast navigation
vim.keymap.set({ "n", "v" }, "H", "5h")
vim.keymap.set({ "n", "v" }, "J", "5j")
vim.keymap.set({ "n", "v" }, "K", "5k")
vim.keymap.set({ "n", "v" }, "L", "5l")

-- Fast command
vim.keymap.set({ "n", "v" }, ";", ":")
