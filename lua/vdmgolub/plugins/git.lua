return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "ruifm/gitlinker.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    lazy = true,
    opts = {
      mappings = nil, -- reset default mappings
    },
    config = true,
  },
  {
    "Rawnly/gist.nvim",
    cmd = { "GistCreate", "GistCreateFromFile", "GistsList" },
    config = {
      private = true, -- All gists will be private, you won't be prompted again
    },
  },
}
