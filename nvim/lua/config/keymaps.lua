-- Utility function to set key mappings with description
local function opts(desc)
    return { noremap = true, silent = true, desc = desc }
end

-- Set the leader key to space
vim.g.mapleader = " "
-- vim.g.maplocalleader = ' '


-- Makes the space key do nothing in normal and visual modes
vim.keymap.set({ "n", "v" }, "<leader>", "<Nop>", opts("Disable Space in normal and visual mode"))

-- Move selected lines down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts("Move selected lines down in visual mode"))

-- Move selected lines up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts("Move selected lines up in visual mode"))

-- Join lines and restore cursor position in normal mode
vim.keymap.set("n", "J", "mzJ`z", opts("Join lines and restore cursor position"))

-- Scroll down and center in normal mode
vim.keymap.set("n", "<C-d>", "<C-d>zz", opts("Scroll down and center screen"))

-- Scroll up and center in normal mode
vim.keymap.set("n", "<C-u>", "<C-u>zz", opts("Scroll up and center screen"))

-- Search next and center in normal mode
vim.keymap.set("n", "n", "nzzzv", opts("Search next and center screen"))

-- Search previous and center in normal mode
vim.keymap.set("n", "N", "Nzzzv", opts("Search previous and center screen"))

-- Delete selection into black hole register in visual mode
vim.keymap.set("x", "<leader>p", [["_dP"]], opts("Delete into black hole register"))

-- Yank to clipboard in normal and visual mode
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], opts("Yank to clipboard"))

-- Yank entire line to clipboard in normal mode
vim.keymap.set("n", "<leader>Y", [["+Y]], opts("Yank entire line to clipboard"))

-- Delete into black hole register in normal and visual mode
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d"]], opts("Delete into black hole register"))

-- Disable the Q key in normal mode
vim.keymap.set("n", "Q", "<nop>", opts("Disable Q in normal mode"))

-- Navigate compiler errors forward and center screen
vim.keymap.set("n", "<M-j>", ":cnext<CR>zz", opts("Navigate to next compiler error"))

-- Navigate compiler errors backward and center screen
vim.keymap.set("n", "<M-k>", ":cprev<CR>zz", opts("Navigate to previous compiler error"))


-- Toggle Undotree
vim.keymap.set("n", "<Leader>u", ":UndotreeToggle<CR>", opts("Toggle Undotree"))

-- Disable arrows
vim.keymap.set({ "n", "i" }, "<Up>", "<Nop>", opts("Disable Up Arrow"))
vim.keymap.set({ "n", "i" }, "<Down>", "<Nop>", opts("Disable Down Arrow"))
vim.keymap.set({ "n", "i" }, "<Left>", "<Nop>", opts("Disable Left Arrow"))
vim.keymap.set({ "n", "i" }, "<Right>", "<Nop>", opts("Disable Right Arrow"))

-- LSP Keymaps
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts("LSP: Go to declaration"))
vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts("LSP: Go to definition"))
vim.keymap.set("n", "K", vim.lsp.buf.hover, opts("LSP: Hover information"))
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts("LSP: Go to implementation"))
vim.keymap.set("n", "<leader>k", vim.lsp.buf.signature_help, opts("LSP: Show signature help"))
vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts("LSP: Add workspace folder"))
vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts("LSP: Remove workspace folder"))
vim.keymap.set("n", "<leader>wl", vim.lsp.buf.list_workspace_folders, opts("LSP: List workspace folders"))
vim.keymap.set("n", "<leader>gT", vim.lsp.buf.type_definition, opts("LSP: Go to type definition"))
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts("LSP: Rename symbol"))
-- vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts("LSP: Code actions"))
vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts("LSP: Document Symbols"))
vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts("LSP: List references"))
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts("Diagnostics: Go to previous diagnostic"))
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts("Diagnostics: Go to next diagnostic"))
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, opts("LSP: Format buffer"))

vim.keymap.set("n", "<leader>E", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>", opts("Insert Go error handling"))

-- Resize window
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", opts("Increase Window Height"))
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", opts("Decrease Window Height"))
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", opts("Decrease Window Width"))
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts("Increase Window Width"))

-- Buffer navigation
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", opts("Prev Buffer"))
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", opts("Next Buffer"))
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", opts("Prev Buffer"))
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", opts("Next Buffer"))
vim.keymap.set("n", "-", "<CMD>Oil<CR>", opts("Open parent directory"))
