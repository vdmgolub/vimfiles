return {
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
        filetypes = {
          markdown = true,
          help = true,
        },
        -- logger = {
        --   file = "/Users/vdmgolub/.local/state/nvim/copilot-lua.log",
        --   file_log_level = 0,
        --   log_lsp_messages = true,
        --   print_log_level = 3,
        --   trace_lsp = "verbose",
        --   trace_lsp_progress = true,
        -- },
      })
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "zbirenbaum/copilot.lua" },
    config = function()
      require("copilot_cmp").setup()

      -- Shim client.is_stopped() → client:is_stopped() (dot-call removed in Nvim 0.13)
      local source = require("copilot_cmp.source")
      local orig = source.is_available
      source.is_available = function(self)
        if self.client and not rawget(self.client, "_is_stopped_shimmed") then
          local real = self.client.is_stopped
          local c = self.client
          rawset(c, "is_stopped", function() return real(c) end)
          rawset(c, "_is_stopped_shimmed", true)
        end
        return orig(self)
      end
    end,
  },
}
