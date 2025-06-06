return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          path_display = { "truncate " },
          mappings = {
            i = {
              -- ["<C-k>"] = actions.move_selection_previous, -- move to prev result
              -- ["<C-j>"] = actions.move_selection_next, -- move to next result
              ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
          },
        },
        buffers = {
          show_all_buffers = true,
          sort_lastused = true,
          theme = "dropdown",
          previewer = false,
          ignore_current_buffer = true,
          mappings = {
            n = {
              ["<C-k>"] = "delete_buffer",
            },
            i = {
              ["<C-k>"] = "delete_buffer",
            },
          },
        },
      })

      telescope.load_extension("fzf")

      -- set keymaps
      local keymap = vim.keymap -- for conciseness

      keymap.set("n", "<leader>t", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
      -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
      keymap.set("n", "<leader>gg", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
      -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })

      keymap.set("n", "<leader><space>", function()
        require("telescope.builtin").buffers({ sort_mru = true, ignore_current_buffer = true })
      end, { desc = "[ ] Find existing buffers" })
    end,
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     "debugloop/telescope-undo.nvim",
  --   },
  --   config = function()
  --     require("telescope").setup({
  --       -- the rest of your telescope config goes here
  --       extensions = {
  --         undo = {
  --           -- telescope-undo.nvim config, see below
  --         },
  --         -- other extensions:
  --         -- file_browser = { ... }
  --       },
  --     })
  --     require("telescope").load_extension("undo")
  --     -- optional: vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
  --   end,
  -- },
}
