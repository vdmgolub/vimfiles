return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
  config = function()
    vim.opt.list = false
    vim.opt.listchars:append("space:⋅")
    vim.opt.listchars:append("eol:↴")
    vim.opt.listchars:append("tab:→ ")

    require("ibl").setup({
      enabled = false,
    })

    vim.keymap.set("n", "<leader>I", function()
      vim.cmd("IBLToggle")
      vim.o.list = not vim.o.list -- Show/Hide list chars
    end)
  end,
}