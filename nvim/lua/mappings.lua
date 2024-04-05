require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", "-", "<cmd>NvimTreeToggle<CR>")

map("i", "jj", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
