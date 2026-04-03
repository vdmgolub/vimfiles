return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true })
        end,
      })
    end,
  },
  {
    "linrongbin16/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    cmd = "GitLink",
    opts = {},
    keys = {
      { "<leader>hb", "<cmd>GitLink default_branch<cr>", mode = { "n", "v" }, desc = "Yank git link" },
      { "<leader>hB", "<cmd>GitLink! default_branch<cr>", mode = { "n", "v" }, desc = "Open git link" },
    },
  },
  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    opts = {
      private = true, -- All gists will be private, you won't be prompted again
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = false,
    },
    config = true,
  },
  {
    "tpope/vim-fugitive",
  },
}
