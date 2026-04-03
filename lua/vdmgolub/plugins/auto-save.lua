return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      write_all_buffers = true,
      trigger_events = { "BufLeave", "FocusLost" },
      execution_message = {
        message = function() return "" end,
      },
    })
  end,
}
