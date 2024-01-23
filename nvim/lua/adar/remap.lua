vim.g.mapleader = " "

vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "N", "Nzz")
vim.keymap.set("n", "n", "nzz")

vim.keymap.set("v", "<leader>p", '"_dP')
