return {
  { "dmmulroy/ts-error-translator.nvim" },
  -- typescript-tools.nvim replaced by vtsls LSP server (via Mason)
  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   config = function()
  --     local lsp = require("vdmgolub.lsp")
  --     require("typescript-tools").setup({
  --       capabilities = lsp.capabilities(),
  --       on_attach = lsp.on_attach,
  --     })
  --   end,
  -- },
}
