return {
  "renerocksai/telekasten.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-telescope/telescope.nvim" },
  opts = {
    home = vim.fn.expand("~/Documents/zettelkasten"), -- Put the name of your notes directory here
    templates = "~/Documents/zettelkasten/templates",
    dailies = "~/Documents/zettelkasten/daily",
    vaults = {
      personal = {
        home = "~/Documents/zettelkasten/vaults/personal",
      },
      infracost = {
        home = "~/Documents/zettelkasten/vaults/infracost",
      },
    },
  },
}
