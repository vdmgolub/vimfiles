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

-- Remap for dealing with word wrap
keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Gist
keymap.set(
  "n",
  "<leader>hh",
  "<cmd>GistCreate from vim<cr>",
  { silent = true, desc = "Create a GitHub gist from current buffer" }
)
keymap.set("v", "<leader>hh", "<cmd>GistCreate from vim<cr>", { desc = "Create a GitHub gist from selection" })

-- Aerial
keymap.set("n", "<leader>cl", "<cmd>AerialToggle<cr>", { silent = true, desc = "Toggle Aerial" })
keymap.set("n", "<leader>cb", "<cmd>GitBlameToggle<cr>", { silent = true, desc = "Toggle GitBlame" })

-- Navigate to the name of the enclosing function (treesitter-based)
keymap.set("n", "gF", function()
  local function_types = {
    function_declaration = true,
    method_definition = true,
    function_expression = true,
  }
  local node = vim.treesitter.get_node()
  while node do
    local t = node:type()
    if function_types[t] then
      local name_node = node:field("name")[1]
      if name_node then
        local row, col = name_node:start()
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
        return
      end
    elseif t == "variable_declarator" then
      -- handles: const foo = () => {} or const foo = function() {}
      local name_node = node:field("name")[1]
      if name_node then
        local row, col = name_node:start()
        vim.api.nvim_win_set_cursor(0, { row + 1, col })
        return
      end
    end
    node = node:parent()
  end
  vim.notify("No enclosing named function found", vim.log.levels.WARN)
end, { desc = "Go to enclosing function name" })

-- Lazy
keymap.set("n", "<leader>lu", "<cmd>Lazy update<cr>", { silent = true, desc = "Update plugins" })

keymap.set('i', '<C-c>', '<Esc>', { noremap = true, desc = 'Exit insert mode' })
keymap.set('n', '<leader>rl', function()
  -- Clear module cache
  for name, _ in pairs(package.loaded) do
    if name:match("^vdmgolub") then
      package.loaded[name] = nil
    end
  end
  -- Source init.lua
  vim.cmd.source(vim.env.MYVIMRC)
  vim.notify("Reloaded all lua modules!", vim.log.levels.INFO)
end, { noremap = true, desc = 'Reload all lua modules' })
