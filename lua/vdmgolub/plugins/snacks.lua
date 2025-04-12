return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    lazygit = {
      enabled = true,
      configure = true,
    },
    git = { enabled = true },
  },
  keys = {
    {
      "<leader>lg",
      function()
        Snacks.lazygit()
      end,
      desc = "Lazygit",
    },
    {
      "<leader>hl",
      function()
        Snacks.git.blame_line()
      end,
      desc = "Git blame line",
    },
  },
}
