return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local lualine = require("lualine")
    local lazy_status = require("lazy.status") -- to configure lazy pending updates count

    local colors = {
      blue = "#65D1FF",
      green = "#3EFFDC",
      violet = "#FF61EF",
      yellow = "#FFDA7B",
      red = "#FF4A4A",
      fg = "#c3ccdc",
      bg = "#112638",
      inactive_bg = "#2c3043",
    }

    local my_lualine_theme = {
      normal = {
        a = { bg = colors.blue, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.violet, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg, gui = "bold" },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.inactive_bg, fg = colors.semilightgray, gui = "bold" },
        b = { bg = colors.inactive_bg, fg = colors.semilightgray },
        c = { bg = colors.inactive_bg, fg = colors.semilightgray },
      },
    }

    -- configure lualine with modified theme
    lualine.setup({
      options = {
        theme = my_lualine_theme,
      },
      sections = {
        lualine_x = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          {
            function()
              local clients = vim.lsp.get_clients({ name = "vtsls", bufnr = 0 })
              return #clients > 0 and "TS" or "TS ✗"
            end,
            color = function()
              local clients = vim.lsp.get_clients({ name = "vtsls", bufnr = 0 })
              return { fg = #clients > 0 and "#3EFFDC" or "#FF4A4A" }
            end,
            cond = function()
              return vim.tbl_contains(
                { "typescript", "typescriptreact", "javascript", "javascriptreact", "typescript.tsx", "javascript.jsx" },
                vim.bo.filetype
              )
            end,
          },
          {
            function()
              local ok, api = pcall(require, "copilot.api")
              if not ok then return "CP ✗" end
              local s = api.status and api.status.data and api.status.data.status
              if s == "Normal" then return "CP" end
              if s == "InProgress" then return "CP…" end
              return "CP ✗"
            end,
            color = function()
              local ok, api = pcall(require, "copilot.api")
              if not ok then return { fg = "#FF4A4A" } end
              local s = api.status and api.status.data and api.status.data.status
              local c = { Normal = "#3EFFDC", InProgress = "#65D1FF", Warning = "#FFDA7B" }
              return { fg = c[s] or "#FF4A4A" }
            end,
          },
          { "filetype" },
        },
      },
    })
  end,
}
