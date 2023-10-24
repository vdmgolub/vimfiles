-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

--------------------- General Keymaps -------------------

-- use jk to exit insert mode
-- keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- delete single character without copying into register
-- keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" }) -- increment
keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" }) -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>f", ":b#<cr>", { desc = "Switch between two recent buffers" }) -- Switch between two recent buffers

keymap.set("n", "<C-j>", " <C-w>j") -- Navigate easier between panes
keymap.set("n", "<C-k>", " <C-w>k") -- Navigate easier between panes
keymap.set("n", "<C-h>", " <C-w>h") -- Navigate easier between panes
keymap.set("n", "<C-l>", " <C-w>l") -- Navigate easier between panes

-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Git-related
keymap.set(
  "n",
  "<leader>hy",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {})<cr>',
  { silent = true, desc = "Copy URL for buffer range to clipboard" }
)
keymap.set(
  "v",
  "<leader>hy",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {})<cr>',
  { desc = "Copy URL for buffer range to clipboard" }
)
keymap.set(
  "n",
  "<leader>hb",
  '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true, desc = "Open URL for buffer range" }
)
keymap.set(
  "v",
  "<leader>hb",
  '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { desc = "Open URL for buffer range" }
)
keymap.set(
  "n",
  "<leader>hB",
  '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
  { silent = true, desc = "Open repo URL in browser" }
)

-- Gist
keymap.set(
  "n",
  "<leader>hh",
  "<cmd>GistCreate from vim<cr>",
  { silent = true, desc = "Create a GitHub gist from current buffer" }
)
keymap.set("v", "<leader>hh", "<cmd>GistCreate from vim<cr>", { desc = "Create a GitHub gist from selection" })
