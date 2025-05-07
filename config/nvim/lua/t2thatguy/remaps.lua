-- Leaders
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enter vim file tree
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Me no like pressing esc :)
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Reload Config
vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Clear highlights from searches
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Moving through splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
