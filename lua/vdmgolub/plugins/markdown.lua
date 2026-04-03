return {
  {
    "bullets-vim/bullets.vim",
    ft = { "markdown", "text" },
    init = function()
      vim.g.bullets_enabled_file_types = { "markdown", "text" }
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
    ---@module 'render-markdown'
    ---@type render.md.UserConfig
    opts = {
      injections = { enabled = false },
    },
  },
}
