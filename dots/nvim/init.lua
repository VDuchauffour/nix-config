-- General
vim.opt.relativenumber = true
vim.opt.showmatch = true
vim.g.mapleader = " "
vim.opt.wrap = true
vim.cmd("set clipboard=unnamedplus")

-- Keymappings
-- set Y to yanking from cursor to the end of the line
vim.keymap.set({ "n", "v" }, "Y", "y$", { silent = true })
vim.keymap.set({ "n", "v" }, "Y", "y$", { silent = true })
-- delete something without yanking it
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { silent = true })
-- delete a character will not yanking it
vim.keymap.set({ "n", "v" }, "x", '"_x', { silent = true })
vim.keymap.set({ "n", "v" }, "X", '"_X', { silent = true })
-- delete a character will not yanking it
vim.keymap.set({ "n", "v" }, "c", '"_c', { silent = true })
vim.keymap.set({ "n", "v" }, "C", '"_C', { silent = true })
-- replace currently selected text with default register without yanking it
vim.keymap.set("v", "p", "pgvy", { silent = true })
vim.keymap.set("v", "P", "Pgvy", { silent = true })
-- add a keymap for <Esc> and ²
vim.keymap.set({ "i", "n", "v" }, "²", "<esc>", { silent = true })
-- use Leader+w to save the buffer
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { silent = true })
-- use Leader+W to save the buffer without formatting
vim.keymap.set("n", "<leader>W", "<cmd>noa w<cr>", { silent = true })
-- close the buffer
vim.keymap.set("n", "<leader>c", "<cmd>bd<cr>", { silent = true })
-- better indenting
vim.keymap.set("v", "<", "<gv", { silent = true })
vim.keymap.set("v", ">", ">gv", { silent = true })
-- yank the full word when using b or B
vim.keymap.set("n", "yb", "vby", { silent = true })
vim.keymap.set("n", "yB", "vBy", { silent = true })
